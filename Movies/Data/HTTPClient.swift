//
//  HTTPClient.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

final class HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(api: API) async throws -> T {
        let data = try await request(api: api)
        let decoder = JSONDecoder()
        if let dateFormat = api.dateFormat {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    func request(api: API) async throws -> Data {
        let request = try createRequest(api: api)
        let (data, _) = try await session.data(for: request)
        return data
    }
    
    private func createRequest(api: API) throws -> URLRequest {
        guard let url = api.url else {
            throw RequestError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = api.method.rawValue
        request.allHTTPHeaderFields = api.headers
        if let body = api.body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        return request
    }
}
