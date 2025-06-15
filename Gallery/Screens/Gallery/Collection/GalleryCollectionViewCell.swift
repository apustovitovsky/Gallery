//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import Kingfisher
import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let likesImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.15
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension GalleryCollectionViewCell {
    func configure(with item: GalleryView.Item) {
        imageView.kf.setImage(with: .network(item.imageURL))
        descriptionLabel.text = item.description
        likesLabel.text = "\(item.likes)"
    }
}

// MARK: - Private methods

private extension GalleryCollectionViewCell {
    func setupViews() {
        contentView.addSubview(imageView)
        imageView.addSubview(overlayView)
        overlayView.addSubview(descriptionLabel)
        overlayView.addSubview(likesImageView)
        overlayView.addSubview(likesLabel)
    }

    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            overlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -12),

            likesImageView.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 8),
            likesImageView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -10),
            likesImageView.trailingAnchor.constraint(equalTo: likesLabel.leadingAnchor, constant: -4),
            likesImageView.widthAnchor.constraint(equalToConstant: 18),
            likesImageView.heightAnchor.constraint(equalToConstant: 18),

            likesLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -12),
            likesLabel.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor)
        ])
    }
}

