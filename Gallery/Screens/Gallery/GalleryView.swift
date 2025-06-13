//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

final class GalleryView: UIView {

    // MARK: - UI Elements

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = tableManager
        collection.delegate = tableManager
        collection.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.self.description())
        return collection
    }()

    private let tableManager = GalleryCollectionViewManager()

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

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCellSize()
    }
}

// MARK: - Configuration

extension GalleryView {
    func configure(with model: Model) {
        tableManager.configure(with: model.imageItems)
        collectionView.reloadData()
    }
}

// MARK: - Model

extension GalleryView {
    struct Model {
        let imageItems: [Item]
    }

    struct Item {
        let imageURL: URL
        let onSelect: () -> Void
    }
}

// MARK: - Setup methods

private extension GalleryView {
    func setupViews() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension GalleryView {
    /// Обновить размер ячейки под разные устройства и ориентации
    func updateCellSize() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let spacing: CGFloat = 16
        let availableWidth = collectionView.bounds.width - spacing
        let numberOfItemsPerRow = max(floor(availableWidth / (100 + spacing)), 1)
        let totalSpacing = spacing * (numberOfItemsPerRow - 1)
        let itemWidth = (availableWidth - totalSpacing) / numberOfItemsPerRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
    }
}
