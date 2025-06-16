//
//  Created by Alexey Pustovitovsky.
//

import UIKit

final class IntroductionView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityTraits = .header
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle(String(localized: "introduction_continue_button_title"), for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.accessibilityHint = String(localized: "introduction_continue_button_hint")
        return button
    }()
    
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
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewModel Binding

    private var onContinueTapped: (() -> Void)?
}

extension IntroductionView {
    func configure(with model: Model) {
        titleLabel.text = model.title
        welcomeLabel.text = model.welcomeMessage
        onContinueTapped = model.onContinue
    }
}

// MARK: - Model

extension IntroductionView {
    struct Model {
        let title: String
        let welcomeMessage: String
        let onContinue: () -> Void
    }
}

private extension IntroductionView {
    func setupViews() {
        [titleLabel, welcomeLabel, continueButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        [titleLabel, welcomeLabel, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            welcomeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            continueButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
