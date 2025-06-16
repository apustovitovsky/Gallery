//
//  Created by Alexey Pustovitovsky.
//

import UIKit

protocol IntroductionRouterProtocol {
    var dismissIntroduction: (() -> Void)? { get set }
}

struct IntroductionRouter: IntroductionRouterProtocol {
    var dismissIntroduction: (() -> Void)?
}
