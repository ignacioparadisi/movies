//
//  CustomCollectionViewListCell.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class CustomCollectionViewListCell: UICollectionViewListCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.backgroundColor = UIColor(named: "selectedBackground")
        selectedBackgroundView = view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
