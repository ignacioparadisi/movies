//
//  DropShadowView.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class DropShadowView: UIView {
    private var shadowLayer: CAShapeLayer!
    private let cornerRadius: CGFloat
    private let shadowColor: UIColor
    private let shadowRadius: CGFloat
    private let shadowOpacity: Float
    private let shadowOffset: CGSize
    
    init(cornerRadius: CGFloat, shadowRadius: CGFloat = 3, shadowColor: UIColor = .black, shadowOpacity: Float = 0.2, shadowOffset: CGSize = .zero) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.cornerCurve = .continuous
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
