//
//  Created by Alexey Pustovitovsky on 13.06.2025.
//

import UIKit

struct UnsplashPhotoModel: Identifiable, Decodable {
    let id: String
    let description: String?
    let altDescription: String?
    @HexDecodable var color: UIColor
    let likes: Int
    let urls: PhotoURL
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, description, color, likes, urls, user
        case altDescription = "alt_description"
    }
}

extension UnsplashPhotoModel {
    struct PhotoURL: Decodable {
        let regular: URL
        let thumb: URL
    }

    struct User: Decodable {
        let username: String
    }
}

// MARK: - Hex

@propertyWrapper
struct HexDecodable {
    let wrappedValue: UIColor
}

extension HexDecodable: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hexString = try container.decode(String.self)
        self.init(wrappedValue: UIColor(hex: hexString))
    }
}

private extension UIColor {
    convenience init(hex: String) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
