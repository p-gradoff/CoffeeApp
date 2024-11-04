//
//  FontsProvider.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit

enum FontType: String {
    case displayRegular = "SFUIText-Regular"
    case displayMedium = "SFUIText-Medium"
    case displayBold = "SFUIText-Bold"
    case montserrat = "Montserrat-Regular"
}

extension UIFont {
    static func getFont(fontType: FontType, size: CGFloat = 16) -> UIFont {
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
