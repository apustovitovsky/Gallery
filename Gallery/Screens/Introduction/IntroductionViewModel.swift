//
//  Created by Alexey Pustovitovsky.
//

import Foundation

protocol IntroductionViewModelProtocol {
    func viewDidLoad()
}

final class IntroductionViewModel {
    weak var view: IntroductionViewProtocol?
    var router: IntroductionRouterProtocol?
    private let modelFactory: IntroductionModelFactoryProtocol
    
    init(
        modelFactory: IntroductionModelFactoryProtocol
    ) {
        self.modelFactory = modelFactory
    }
}

extension IntroductionViewModel: IntroductionViewModelProtocol {
    
    func viewDidLoad() {
        let model = modelFactory.create(
            title: String(localized: "introduction_title"),
            welcomeMessage: String(localized: "introduction_welcome_message")
        ) { [weak self] in
            self?.continueHandler()
        }
        view?.configure(with: model)
    }
}

private extension IntroductionViewModel {
    func continueHandler() {
        router?.onContinue()
    }
}

