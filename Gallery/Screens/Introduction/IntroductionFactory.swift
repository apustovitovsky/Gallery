//
//  Created by Alexey Pustovitovsky.
//

import UIKit

struct IntroductionFactory {
    let navigationController: UINavigationController

    func create() -> UIViewController {

        let viewModel = IntroductionViewModel(
            modelFactory: IntroductionModelFactory())

        let controller = IntroductionViewController(viewModel: viewModel)
        viewModel.view = controller
        
        var router = IntroductionRouter()
        router.dismissIntroduction = { [weak controller] in
            UserDefaults.hasSeenAppIntroduction = true
            controller?.dismiss(animated: true)
        }
        viewModel.router = router

        return controller
    }
}
