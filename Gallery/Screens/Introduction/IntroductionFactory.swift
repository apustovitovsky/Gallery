//
//  Created by Alexey Pustovitovsky.
//

import UIKit

struct IntroductionFactory {
    let navigationController: UINavigationController

    func create(onFinish: @escaping () -> Void) -> UIViewController {

        let viewModel = IntroductionViewModel(
            modelFactory: IntroductionModelFactory())

        let controller = IntroductionViewController(viewModel: viewModel)
        controller.isModalInPresentation = true
        
        viewModel.view = controller
        
        let router = IntroductionRouter(onContinue: { onFinish() })
        viewModel.router = router

        return controller
    }
}
