//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

protocol GalleryViewProtocol: AnyObject {
    func update(with model: GalleryViewController.Model)
}

final class GalleryViewController: UIViewController {
    private let viewModel: GalleryViewModel
    private let customView = GalleryView()

    init(viewModel: GalleryViewModel) {
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

// MARK: - GalleryViewProtocol

extension GalleryViewController: GalleryViewProtocol {
    func update(with model: Model) {
        title = model.title
        customView.configure(with: model.modelForView)
    }
}

// MARK: - Model

extension GalleryViewController {
    struct Model {
        let title: String
        let modelForView: GalleryView.Model
    }
}
