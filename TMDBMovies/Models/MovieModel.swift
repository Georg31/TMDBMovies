//
//  MovieModel.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/9/21.
//

import UIKit

class Movies: Equatable {
    static func == (lhs: Movies, rhs: Movies) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var originalTitle, overview: String
    var posterPath, releaseDate, title: String
    var voteAverage: Double
    var favourite: Bool
    var img: UIImage?
    
    init(param: MovieData) {
        self.id = param.id
        self.originalTitle = param.originalTitle
        self.overview = param.overview
        self.posterPath = param.posterPath
        self.releaseDate = param.releaseDate
        self.title = param.title
        self.voteAverage = param.voteAverage
        self.favourite = false
    }
    
    init(param: UserMovies) {
        self.id = Int(param.iD)
        self.originalTitle = param.originalTitle!
        self.overview = param.review!
        self.releaseDate = param.releaseDate!
        self.title = param.title!
        self.voteAverage = param.voteAvarage
        self.favourite = param.favourite
        self.img = UIImage(data: param.poster!)
        self.posterPath = ""
    }
    
}
