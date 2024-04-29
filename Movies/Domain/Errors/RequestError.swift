//
//  RequestError.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

enum RequestError: Error {
    case invalidURL
    case emptyResponse
}

extension RequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid"
        case .emptyResponse:
            return "Service returned an empty response"
        }
    }
}
