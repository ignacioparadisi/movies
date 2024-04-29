//
//  Movie.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/24/24.
//

import Foundation

struct Movie: Decodable, Hashable {
    let id: Int
    let genreIds: [Int]
    let isForAdults: Bool
    let backdropPath: String
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let title: String
    let overview: String
    let popularity: Double
    let releaseDate: Date
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case genreIds = "genre_ids"
        case isForAdults = "adult"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title
        case overview
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
