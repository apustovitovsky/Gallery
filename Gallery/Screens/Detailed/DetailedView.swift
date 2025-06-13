//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit
import Kingfisher

final class DetailedView: UIView {

    // MARK: - UI Elements

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension DetailedView {
    func configure(with model: Model) {
        imageView.kf.setImage(with: .network(model.imageURL))
    }
}

// MARK: - Model

extension DetailedView {
    struct Model: Equatable {
        let imageURL: URL
    }
}

// MARK: - Setup methods

private extension DetailedView {
    func setupViews() {
        addSubview(imageView)
    }

    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
