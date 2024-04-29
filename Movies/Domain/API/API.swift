//
//  API.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPScheme: String {
    case http
    case https
}

protocol API {
    var method: HTTPMethod { get }
    var scheme: HTTPScheme { get }
    var host: String { get }
    var headers: [String: String]? { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var dateFormat: String? { get }
    var body: Encodable? { get }
}

extension API {
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.queryItems = parameters
        return components.url
    }
}
