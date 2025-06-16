//
//  Created by Alexey Pustovitovsky.
//

import UIKit

protocol IntroductionViewProtocol: AnyObject {
    func configure(with model: IntroductionView.Model)
}

final class IntroductionViewController: UIViewController {
    private let viewModel: IntroductionViewModelProtocol
    private let customView = IntroductionView()
    
    // MARK: - Init
    
    init(viewModel: IntroductionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

// MARK: - IntroductionViewProtocol

extension IntroductionViewController: IntroductionViewProtocol {
    func configure(with model: IntroductionView.Model) {
        customView.configure(with: model)
    }
}

