//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryModelFactoryProtocol {
    func create(from models: [UnsplashPhotoModel], onSelect: @escaping (String) -> Void) -> [GalleryView.Item]
}

struct GalleryModelFactory: GalleryModelFactoryProtocol {
    func create(from models: [UnsplashPhotoModel], onSelect: @escaping (String) -> Void) -> [GalleryView.Item] {
        models.map { unsplashPhotoModel in
            GalleryView.Item(
                imageURL: unsplashPhotoModel.urls.thumb,
                onSelect: { onSelect(unsplashPhotoModel.id) }
            )
        }
    }
}
