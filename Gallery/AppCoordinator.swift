//
//  Created by Alexey Pustovitovsky.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let photoRepository: PhotoRepository
    
    init(
        navigationController: UINavigationController,
        photoRepository: PhotoRepository
    ){
        self.navigationController = navigationController
        self.photoRepository = photoRepository
    }
    
    override func start(with option: LaunchOptions?) {
        switch option {
        case .detailed(let context):
            showGallery()
            showDetailed(context: context)
        default:
            showGallery()
        }
        
        if !UserDefaults.hasSeenAppIntroduction {
            showIntroduction()
        }
    }
}

private extension AppCoordinator {
    func showIntroduction() {
        let navigationController = UINavigationController()
        let factory = IntroductionFactory(navigationController: navigationController)
        
        let viewController = factory.create { [weak navigationController] in
            UserDefaults.hasSeenAppIntroduction = true
            navigationController?.dismiss(animated: true)
        }
        
        navigationController.setViewControllers( [viewController], animated: false)
        self.navigationController.present(navigationController, animated: true)
    }
    
    func showGallery() {
        let factory = GalleryFactory(
            photoRepository: photoRepository,
            navigationController: navigationController)
        
        let viewController = factory.create { [weak self] photo in
            self?.showDetailed(context: photo)
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showDetailed(context: UnsplashPhotoModel) {
        let factory = DetailedFactory()
        let viewController = factory.create(with: context)
        navigationController.pushViewController(viewController, animated: true)
    }
}


