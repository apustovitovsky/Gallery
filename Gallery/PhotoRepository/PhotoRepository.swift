//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol PhotoRepositoryProtocol: AnyObject {
    /// Источник данных для разных экранов.
    /// Хранит информацию, которая может быть передана любому экрану для создания модели View.
    var photos: [UnsplashPhotoModel] { get }

    /// Загружает фотографии из API Unsplash.
    /// - Parameter completion: Замыкание, вызываемое после завершения загрузки.
    func fetchPhotos(completion: @escaping (Result<[UnsplashPhotoModel], Error>) -> Void)
}

/// Класс PhotoRepository отвечает за загрузку и хранение фотографий из API Unsplash.
/// Он является источником данных для разных экранов приложения, предоставляя массив фотографий.
/// Также реализует кэширование API-запросов для оптимизации работы с сетью.
class PhotoRepository {
    private static let sharedPhotoURLCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024)

    private let apiKey: String
    var photos: [UnsplashPhotoModel] = []

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    enum PhotoProviderError: Error {
        case invalidURL
        case noData
    }
}

extension PhotoRepository: PhotoRepositoryProtocol {
    func fetchPhotos(completion: @escaping (Result<[UnsplashPhotoModel], Error>) -> Void) {
        fetchPhotosWithURLSession(completion: { [weak self] in
            guard let self else { return }

            self.photos = (try? $0.get()) ?? []
            completion($0)
        })
    }
}

private extension PhotoRepository {
    func fetchPhotosWithURLSession(completion: @escaping (Result<[UnsplashPhotoModel], Error>) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=" + apiKey) else {
            completion(.failure(PhotoProviderError.invalidURL))
            return
        }

        let config = URLSessionConfiguration.default
        config.urlCache = Self.sharedPhotoURLCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: config)

        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }

                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(PhotoProviderError.noData))
                }

                return
            }

            do {
                let photos = try JSONDecoder().decode([UnsplashPhotoModel].self, from: data)

                DispatchQueue.main.async {
                    completion(.success(photos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
