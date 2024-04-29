//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import UIKit
import Combine

class MoviesListViewController: UICollectionViewController {
    private let viewModel: ViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Movie>!
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureCollectionView()
        subscribeToChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func subscribeToChanges() {
        viewModel.$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }
    
    private func setupNavigationBar() {
        title = LocalizationStrings.topRatedMovies
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        setCollectionViewLayout()
        createDataSource()
        applySnapshot()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        let action = UIAction { [weak self] _ in
            self?.fetchMovies()
        }
        refreshControl.addAction(action, for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func fetchMovies() {
        Task {
            do {
                try await viewModel.fetchMovies()
                await MainActor.run {
                    refreshControl.endRefreshing()
                }
            } catch {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                present(alert, animated: true)
            }
        }
    }
}

// MARK: - Collection View Setup
extension MoviesListViewController {
    private func setCollectionViewLayout() {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.footerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func createDataSource() {
        let cellRegistration = getCellRegistration()
        let footerRegistration = getLoadingFooterRegistration()
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
        }
        collectionView.dataSource = dataSource
    }
    
    private func getCellRegistration() -> UICollectionView.CellRegistration<MovieCell, Movie> {
        return UICollectionView.CellRegistration { cell, indexPath, movie in
            cell.configure(with: movie)
        }
    }
    
    private func getLoadingFooterRegistration() -> UICollectionView.SupplementaryRegistration<UICollectionViewListCell> {
        return UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionFooter) { [weak self] supplementaryView, elementKind, indexPath in
            let loadingIndicator = UIActivityIndicatorView(style: .medium)
            supplementaryView.addSubview(loadingIndicator)
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingIndicator.topAnchor.constraint(equalTo: supplementaryView.topAnchor, constant: 16),
                loadingIndicator.bottomAnchor.constraint(equalTo: supplementaryView.bottomAnchor, constant: -16),
                loadingIndicator.centerXAnchor.constraint(equalTo: supplementaryView.centerXAnchor),
                loadingIndicator.centerYAnchor.constraint(equalTo: supplementaryView.centerYAnchor)
            ])
            guard let self else { return }
            if viewModel.totalNumberOfItems == 0 || indexPath.item < viewModel.totalNumberOfItems {
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= viewModel.movies.count - 5 {
            fetchMovies()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewModel = viewModel.detailViewModel(at: indexPath) else { return }
        let controller = MovieDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}


