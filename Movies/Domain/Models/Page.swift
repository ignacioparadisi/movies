//
//  Page.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

struct Page<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
        
    }
}
