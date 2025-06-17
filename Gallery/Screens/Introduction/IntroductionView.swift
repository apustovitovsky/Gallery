//
//  Created by Alexey Pustovitovsky.
//

import UIKit

final class IntroductionView: UIView {

    // MARK: - UI Elements

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.accessibilityTraits = .header
        return label
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let continueButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = String(localized: "introduction_continue_button_title")
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.accessibilityHint = String(localized: "introduction_continue_button_hint")
        return button
    }()

    private var onContinueTapped: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()

        continueButton.addAction(UIAction { [weak self] _ in
            self?.onContinueTapped?()
        }, for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension IntroductionView {
    func configure(with model: Model) {
        titleLabel.text = model.title
        welcomeLabel.text = model.welcomeMessage
        onContinueTapped = model.onContinue
    }

    struct Model {
        let title: String
        let welcomeMessage: String
        let onContinue: () -> Void
    }
}

// MARK: - Layout

private extension IntroductionView {
    func setupViews() {
        [titleLabel, welcomeLabel, continueButton].forEach { addSubview($0) }
    }

    func setupConstraints() {
        [titleLabel, welcomeLabel, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            welcomeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            continueButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 256),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
