//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/25/24.
//

import Foundation

extension MovieDetailViewController {
    class ViewModel {
        private let movie: Movie
        
        var title: String {
            movie.title
        }
        var imagePath: String {
            movie.posterPath
        }
        var overview: String {
            movie.overview
        }
        var rating: Float {
            movie.voteAverage / 2
        }
        var releaseDate: String {
            movie.releaseDate.formatted(date: .long, time: .omitted)
        }
        
        init(movie: Movie) {
            self.movie = movie
        }
    }
}
