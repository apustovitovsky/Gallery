//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryRouterProtocol {
    func pushToDetailed(with context: UnsplashPhotoModel)
}

struct GalleryRouter: GalleryRouterProtocol {
    let navigationController: UINavigationController?

    func pushToDetailed(with context: UnsplashPhotoModel) {
        let factory = DetailedFactory()
        let detailedViewController = factory.create(with: context)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
