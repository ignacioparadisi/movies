//
//  RatingView.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class RatingView: UIView {
    private let stackView = UIStackView()
    var font: UIFont = .preferredFont(for: .body) {
        didSet {
            for view in stackView.arrangedSubviews {
                if let label = view as? UILabel {
                    label.font = font
                } else if let imageView = view as? UIImageView {
                    let configuration = UIImage.SymbolConfiguration(font: font)
                    imageView.image = imageView.image?.withConfiguration(configuration)
                }
            }
        }
    }
    
    init(rating: Float) {
        super.init(frame: .zero)
        initialize(rating: rating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(rating: Float) {
        stackView.axis = .horizontal
        let stars = starRating(from: rating)
        for (index, star) in stars.enumerated() {
            let image = UIImage(systemName: star)
            let imageView = UIImageView(image: image)
            imageView.tintColor = .tintColor
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            stackView.addArrangedSubview(imageView)
            if index == stars.count - 1 {
                stackView.setCustomSpacing(5, after: imageView)
            }
        }
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = String(format: "%.1f", rating)
        stackView.addArrangedSubview(label)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func starRating(from voteAverage: Float) -> [String] {
        let roundedAverage = round(voteAverage * 10) / 10.0
       let fullStars = Int(roundedAverage)
       let remainder = roundedAverage - Float(fullStars)
        var stars: [String] = []

        for _ in 0..<fullStars {
            stars.append("star.fill")
        }
        if remainder > 0 {
            stars.append("star.leadinghalf.filled")
        }
        while stars.count < 5 {
            stars.append("star")
        }

        return stars
    }
}
