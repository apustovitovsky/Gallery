//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import Foundation

final class GalleryViewModel {
    weak var view: GalleryViewProtocol?
    private let router: GalleryRouterProtocol
    private let photoRepository: PhotoRepositoryProtocol
    private let modelFactory: GalleryModelFactoryProtocol

    init(
        router: GalleryRouterProtocol,
        photoRepository: PhotoRepositoryProtocol,
        modelFactory: GalleryModelFactoryProtocol
    ) {
        self.router = router
        self.photoRepository = photoRepository
        self.modelFactory = modelFactory
    }
}

extension GalleryViewModel {
    func viewDidLoad() {
        loadPhotos()
    }
}

private extension GalleryViewModel {
    /// Загрузить и отобразить фотографии
    func loadPhotos() {
        photoRepository.fetchPhotos { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(images):
                let items = modelFactory.create(
                    from: images,
                    onSelect: { [weak self] in
                        self?.selectionHandler(photoID: $0)
                    })

                let model = GalleryViewController.Model(
                    title: String(localized: "gallery_title"),
                    imageItems: items
                )
                view?.update(with: model)
            case .failure:
                router.presentAlert(onRetry: { [weak self] in
                    self?.loadPhotos()
                })
            }
        }
    }

    func selectionHandler(photoID: String) {
        guard let unsplashPhoto = photoRepository.photos.first(where: { $0.id == photoID }) else {
            assertionFailure("Не найден ID в хранилище фотографии")
            return
        }

        router.pushToDetailed(with: unsplashPhoto)
    }
}
