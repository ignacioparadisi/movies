//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

class RemoteDataSource: RemoteDataSourceProvider {
    private let client: HTTPClient
    
    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }
    
    func getTopRatedMovies(for page: Int) async throws -> Page<Movie> {
        let api = MoviesAPI.getTopRatedMovies(page: page)
        return try await client.request(api: api)
    }
    
    func getImage(with path: String) async throws -> Data {
        let api = MoviesAPI.getImage(path: path)
        return try await client.request(api: api)
    }
}
