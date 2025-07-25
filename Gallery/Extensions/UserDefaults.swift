//
//  Created by Alexey Pustovitovsky.
//

import Foundation


extension UserDefaults {

    @UserDefault(key: "has_seen_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
