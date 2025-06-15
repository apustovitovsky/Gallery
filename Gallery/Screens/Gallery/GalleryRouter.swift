//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryRouterProtocol {
    func pushToDetailed(with context: UnsplashPhotoModel)
    func presentAlert(onRetry: @escaping (() -> Void))
}

struct GalleryRouter: GalleryRouterProtocol {
    let navigationController: UINavigationController?

    func pushToDetailed(with context: UnsplashPhotoModel) {
        let factory = DetailedFactory()
        let detailedViewController = factory.create(with: context)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }

    func presentAlert(onRetry: @escaping (() -> Void)) {
        let alert = UIAlertController(title: String(localized: "gallery_error_title"), message: nil, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: String(localized: "gallery_error_retry_button"), style: .default, handler: { _ in
            onRetry()
        })
        alert.addAction(retryAction)
        navigationController?.present(alert, animated: true)
    }
}
