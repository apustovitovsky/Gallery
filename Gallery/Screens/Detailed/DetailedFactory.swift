//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

struct DetailedFactory {
    init() {}

    func create(with context: UnsplashPhotoModel) -> UIViewController {
        let viewModel = DetailedViewModel(context: context)

        let controller = DetailedViewController(viewModel: viewModel)
        viewModel.view = controller

        return controller
    }
}
