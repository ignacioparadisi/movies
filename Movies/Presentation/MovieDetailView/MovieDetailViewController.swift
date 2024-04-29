//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let imageHeight: CGFloat = 400
    private let imageView = DropShadowImageView(cornerRadius: 20, shadowRadius: 20, shadowOpacity: 0.6)
    private let stackView: UIStackView = UIStackView()
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupContent()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupContent() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        setupImage()
        setupTitleLabel()
        setupReleaseDateLabel()
        setupRatingView()
        setupOverviewLabel()
    }
    
    private func setupImage() {
        stackView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3)
        ])
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.font = .preferredFont(for: .title1, weight: .bold)
        label.text = viewModel.title
        label.numberOfLines = 0
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
        stackView.setCustomSpacing(5, after: label)
    }
    
    private func setupRatingView() {
        let view = RatingView(rating: viewModel.rating)
        view.font = .preferredFont(for: .footnote)
        stackView.addArrangedSubview(view)
    }
    
    private func setupReleaseDateLabel() {
        let calendarImageView = UIImageView(image: UIImage(systemName: "calendar"))
        let dateLabel = UILabel()
        dateLabel.textColor = .secondaryLabel
        dateLabel.text = viewModel.releaseDate
        dateLabel.font = .preferredFont(for: .footnote)
        let stackView = UIStackView(arrangedSubviews: [calendarImageView, dateLabel])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        self.stackView.addArrangedSubview(stackView)
        self.stackView.setCustomSpacing(5, after: stackView)
    }
    
    private func setupOverviewLabel() {
        let label = UILabel()
        label.text = viewModel.overview
        label.numberOfLines = 0
        label.textAlignment = .justified
        stackView.addArrangedSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.load(from: viewModel.imagePath)
    }
}
