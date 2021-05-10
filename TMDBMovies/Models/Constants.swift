//
//  Constants.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/7/21.
//

import UIKit

struct Constants {
    static let url = "https://api.themoviedb.org/3/movie/"
    static let topRated = "top_rated?"
    static let popular = "popular?"
    static let imgUrl = "https://image.tmdb.org/t/p/w500/"
    static let movieCell = "MovieCell"
    static let segueId = "DetailsVC"
    static let connection = "Connctivity"
}

extension String {
    func downloadImage(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: Constants.imgUrl + self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
}


extension Array {
    var getMovies: [Movies] {
        var arr = [Movies]()
        for item in self {
            arr.append(Movies(param: item as! MovieData))
        }
        return arr
    }
    
    var getFavs: [Movies]{
        var arr = [Movies]()
        for item in self {
            arr.append(Movies(param: item as! UserMovies))
        }
        return arr
    }
}
