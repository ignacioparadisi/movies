//
//  MovieRepository.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

class MovieRepository: RepositoryProvider {
    private let dataSource: RemoteDataSourceProvider
    private var imageCache = NSCache<NSString, NSData>()
    
    init(dataSource: RemoteDataSourceProvider = RemoteDataSource()) {
        self.dataSource = dataSource
    }
    
    func getTopRatedMovies(for page: Int) async throws -> Page<Movie> {
        return try await dataSource.getTopRatedMovies(for: page)
    }
    
    func getImage(with path: String) async throws -> Data {
        let key = NSString(string: path)
        if let cachedImageData = imageCache.object(forKey: key) {
            return Data(referencing: cachedImageData)
        }
        return try await dataSource.getImage(with: path)
    }
}
