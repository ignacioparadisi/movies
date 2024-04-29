//
//  MovieCell.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class MovieCell: CustomCollectionViewListCell {
    private let imageHeight: CGFloat = 100
    private let imageView: DropShadowImageView = {
        let imageView = DropShadowImageView(cornerRadius: 8, shadowRadius: 5, shadowOpacity: 0.3)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(for: .footnote)
        return label
    }()
    private var ratingView: RatingView?
    private var textStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        accessories = [.disclosureIndicator()]
        textStackView = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel])
        textStackView.axis = .vertical
        textStackView.setCustomSpacing(6, after: releaseDateLabel)
        let stackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        let imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        imageViewHeightConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            imageViewHeightConstraint,
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3)
        ])
    }
    
    func configure(with movie: Movie) {
        imageView.load(from: movie.posterPath)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate.formatted(date: .long, time: .omitted)
        ratingView?.removeFromSuperview()
        ratingView = RatingView(rating: movie.voteAverage / 2)
        ratingView?.font = .preferredFont(for: .caption1)
        textStackView.addArrangedSubview(ratingView!)
    }
}
