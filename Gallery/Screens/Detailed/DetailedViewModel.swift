//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import Foundation

final class DetailedViewModel {
    weak var view: DetailedViewProtocol?

    let context: UnsplashPhotoModel

    init(context: UnsplashPhotoModel) {
        self.context = context
    }
}

extension DetailedViewModel {
    func viewDidLoad() {
        view?.update(with: .init(title: context.user.username, imageURL: context.urls.regular))
    }
}
