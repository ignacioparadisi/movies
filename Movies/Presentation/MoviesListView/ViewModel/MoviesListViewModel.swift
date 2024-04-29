//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation
import Combine

extension MoviesListViewController {
    class ViewModel {
        private let repository: RepositoryProvider
        private var page: Page<Movie>?
        @Published var movies: [Movie] = []
        private(set) var isLoading: Bool = false
        private var task: Task<Page<Movie>, Error>?
        
        init(repository: RepositoryProvider = MovieRepository()) {
            self.repository = repository
        }
        
        func fetchMovies() async throws {
            guard !isLoading, let nextPageNumber = getNextPageNumber() else { return }
            isLoading = true
            defer { isLoading = false }
            task?.cancel()
            task = Task {
                return try await repository.getTopRatedMovies(for: nextPageNumber)
            }
            page = try await task?.value
            if let page {
                movies.append(contentsOf: page.results)
            }
        }
        
        private func getNextPageNumber() -> Int? {
            guard let page else { return 1 }
            guard page.page < page.totalPages else { return nil }
            return page.page + 1
        }
        
        func detailViewModel(at indexPath: IndexPath) -> MovieDetailViewController.ViewModel? {
            let item = indexPath.item
            guard item < movies.count else { return nil }
            let movie = movies[item]
            return MovieDetailViewController.ViewModel(movie: movie)
        }
    }
}
