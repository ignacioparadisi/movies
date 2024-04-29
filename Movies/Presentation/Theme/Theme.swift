//
//  Theme.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import UIKit

class Theme {
    private let font: Font = .proRounded
    
    class func setAppearance() {
        setNavigationBarAppearance()
        setLabelAppearance()
        setButtonAppearance()
    }
    
    private static func setNavigationBarAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(for: .body, weight: .semibold, size: 17),
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(for: .largeTitle, weight: .bold),
        ]
    }
    
    private static func setLabelAppearance() {
        UILabel.appearance().font = .preferredFont(for: .body)
        UILabel.appearance().adjustsFontForContentSizeCategory = true
    }
    
    private static func setButtonAppearance() {
        UIButton.appearance().titleLabel?.font = .preferredFont(for: .body)
    }
}

