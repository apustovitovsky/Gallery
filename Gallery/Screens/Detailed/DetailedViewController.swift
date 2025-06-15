//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol DetailedViewProtocol: AnyObject {
    func update(with model: DetailedViewController.Model)
}

final class DetailedViewController: UIViewController {
    private let viewModel: DetailedViewModel
    private let customView = DetailedView()

    init(viewModel: DetailedViewModel) {
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

// MARK: - DetailedViewProtocol

extension DetailedViewController: DetailedViewProtocol {
    func update(with model: Model) {
        title = model.title
        customView.configure(with: model)
    }
}

// MARK: - Model

extension DetailedViewController {
    struct Model {
        let title: String
        let imageURL: URL
    }
}
