//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryModelFactoryProtocol {
    /// Создает массив моделей для View из сетевых данных.
    /// - Parameters:
    ///   - models: Массив моделей данных Unsplash.
    ///   - onSelect: Замыкание, вызываемое при выборе элемента.
    /// - Returns: Массив моделей для отображения в галерее.
    func create(from models: [UnsplashPhotoModel], onSelect: @escaping (String) -> Void) -> [GalleryViewController.Item]
}

/// Фабрика, создающая модели для View из сетевой модели.
struct GalleryModelFactory: GalleryModelFactoryProtocol {
    func create(from models: [UnsplashPhotoModel], onSelect: @escaping (String) -> Void) -> [GalleryViewController.Item] {
        models.map { unsplashPhotoModel in
            GalleryViewController.Item(
                imageURL: unsplashPhotoModel.urls.thumb,
                description: unsplashPhotoModel.description ?? unsplashPhotoModel.altDescription ?? "",
                color: unsplashPhotoModel.color,
                likes: unsplashPhotoModel.likes,
                onSelect: { onSelect(unsplashPhotoModel.id) }
            )
        }
    }
}
