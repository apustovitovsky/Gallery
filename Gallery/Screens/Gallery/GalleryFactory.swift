//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

struct GalleryFactory {
    let photoRepository: PhotoRepositoryProtocol
    let navigationController: UINavigationController

    func create() -> UIViewController {
        let router = GalleryRouter(navigationController: navigationController)

        let viewModel = GalleryViewModel(
            router: router,
            photoRepository: photoRepository,
            modelFactory: GalleryModelFactory())

        let controller = GalleryViewController(viewModel: viewModel)
        viewModel.view = controller

        return controller
    }
}
