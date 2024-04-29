//
//  RepositoryProvider.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

protocol RepositoryProvider {
    func getTopRatedMovies(for page: Int) async throws -> Page<Movie>
    func getImage(with path: String) async throws -> Data
}
