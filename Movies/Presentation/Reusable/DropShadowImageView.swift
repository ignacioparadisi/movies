//
//  DropShadowImageView.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class DropShadowImageView: UIView {
    private let imageView = UIImageView()
    private let cornerRadius: CGFloat
    private let shadowColor: UIColor
    private let shadowRadius: CGFloat
    private let shadowOpacity: Float
    private let shadowOffset: CGSize
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    init(cornerRadius: CGFloat, shadowRadius: CGFloat = 3, shadowColor: UIColor = .black, shadowOpacity: Float = 0.2, shadowOffset: CGSize = .zero) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        let view = DropShadowView(cornerRadius: cornerRadius, shadowRadius: shadowRadius, shadowColor: shadowColor, shadowOpacity: shadowOpacity, shadowOffset: shadowOffset)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true
    }
    
    func load(from url: String) -> Task<Void, Error>? {
        return imageView.load(from: url)
    }
}
