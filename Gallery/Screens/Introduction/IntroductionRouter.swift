//
//  Created by Alexey Pustovitovsky.
//

import UIKit

protocol IntroductionRouterProtocol {
    var onContinue: () -> Void { get }
}

struct IntroductionRouter: IntroductionRouterProtocol {
    var onContinue: () -> Void
}
