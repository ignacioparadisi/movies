//
//  CustomFont.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import UIKit

extension Theme {
    enum Font: String {
        case proRounded = "SFProRounded"
        
        enum Weight: String {
            case ultralight = "Ultralight"
            case thin = "Thin"
            case light = "Light"
            case regular = "Regular"
            case medium = "Medium"
            case semibold = "Semibold"
            case bold = "Bold"
            case heavy = "Heavy"
            case black = "Black"
        }
        
        func font(textStyle: UIFont.TextStyle, weight: Weight = .regular, defaultSize: CGFloat? = nil) -> UIFont {
            let fontName = [rawValue, weight.rawValue].joined(separator: "-")
            let size = defaultSize ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
            let fontToScale = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size, weight: .regular)
            return textStyle.metrics.scaledFont(for: fontToScale)
        }
    }
}

extension UIFont {
    class func preferredFont(for textStyle: TextStyle, weight: Theme.Font.Weight = .regular, size: CGFloat? = nil) -> UIFont {
        return Theme.Font.proRounded.font(textStyle: textStyle, weight: weight, defaultSize: size)
    }
}
