//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Ignacio Paradisi on 4/29/24.
//

import Foundation

extension MovieCell {
    class ViewModel {
        private let movie: Movie
        
        var imagePath: String {
            movie.posterPath
        }
        var title: String {
            movie.title
        }
        var releaseDate: String {
            movie.releaseDate.formatted(date: .long, time: .omitted)
        }
        var rating: Float {
            movie.voteAverage / 2
        }
        
        init(movie: Movie) {
            self.movie = movie
        }
    }
}
