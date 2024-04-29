//
//  MoviesAPI.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

enum MoviesAPI: API {
    case getTopRatedMovies(page: Int)
    case getImage(path: String)
    
    var method: HTTPMethod {
        switch self {
        case .getTopRatedMovies, .getImage:
            return .get
        }
    }
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var host: String {
        switch self {
        case .getTopRatedMovies:
            return "api.themoviedb.org"
        case .getImage:
            return "image.tmdb.org"
        }
    }
    
    var headers: [String : String]? {
        // TODO: Save this in a secure place
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZjA5NTc3YjVlOGY4ZTY5OTIzOWQxYTc1NWI2ZGZiYyIsInN1YiI6IjY2Mjk3ZWRmNGE0YmY2MDE2NTc3MzY0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.I8mf0w17NtFfRBGdH___qhuci7wz72HL_O3FI0ezcBs"
        return [
            "Authorization": "Bearer \(accessToken)",
            "accept": "application/json"
        ]
    }
    
    var path: String {
        switch self {
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        case .getImage(let path):
            return "/t/p/w500\(path)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getTopRatedMovies(let page):
            let language = Locale.current.identifier.replacingOccurrences(of: "_", with: "-")
            return [
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        default:
            return []
        }
    }
    
    var dateFormat: String? {
        switch self {
        case .getTopRatedMovies:
            return "yyyy-MM-dd"
        default:
            return nil
        }
    }
    
    var body: (any Encodable)? {
        nil
    }
    
    
}
