//
//  Created by Alexey Pustovitovsky.
//

import Foundation

protocol IntroductionModelFactoryProtocol {
    func create(title: String, welcomeMessage: String, onContinue: @escaping () -> Void) -> IntroductionView.Model
}
    
struct IntroductionModelFactory: IntroductionModelFactoryProtocol {
    func create(title: String, welcomeMessage: String, onContinue: @escaping () -> Void) -> IntroductionView.Model {
        .init(
            title: title,
            welcomeMessage: welcomeMessage,
            onContinue: onContinue
        )
    }
}
