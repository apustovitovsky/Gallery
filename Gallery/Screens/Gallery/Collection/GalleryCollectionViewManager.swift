//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

/// Менеджер для управления данными и событиями коллекции галереи.
class GalleryCollectionViewManager: NSObject {
    private var dataSource = [GalleryView.Item]()
}

extension GalleryCollectionViewManager {
    func configure(with models: [GalleryView.Item]) {
        dataSource = models
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionViewManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.self.description(), for: indexPath) as? GalleryCollectionViewCell else {
            assertionFailure("Не удалось создать ячейку")
            return UICollectionViewCell()
        }
        
        let item = dataSource[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}

extension GalleryCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource[indexPath.item]
        item.onSelect()
    }
}
