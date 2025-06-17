//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryRouterProtocol {
    /// Переход на экран детального просмотра фотографии.
    /// - Parameter context: Модель данных фотографии.
    var pushToDetailed: (UnsplashPhotoModel) -> Void { get }

    /// Отображение алерта с возможностью повторить действие.
    /// - Parameter onRetry: Замыкание, вызываемое при выборе действия "Повторить".
    func presentAlert(onRetry: @escaping (() -> Void))
}

struct GalleryRouter: GalleryRouterProtocol {

    let navigationController: UINavigationController
    var pushToDetailed: (UnsplashPhotoModel) -> Void

    func presentAlert(onRetry: @escaping (() -> Void)) {
        let alert = UIAlertController(title: String(localized: "gallery_error_title"), message: nil, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: String(localized: "gallery_error_retry_button"), style: .default, handler: { _ in
            onRetry()
        })
        alert.addAction(retryAction)
        navigationController.present(alert, animated: true)
    }
}
