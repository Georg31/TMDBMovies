//
//  APIService.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/7/21.
//

import Foundation

class Service {
    
    static let shared = Service()
    private init(){}
    
    var page = 1
    var totalPage = 1
    var type = "top_rated?"
    
    func fetchNextPage(type: String, completion: @escaping ([MovieData]) -> Void) {
        
        if !Reachability.isConnectedToNetwork(){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.connection), object: nil, userInfo: [:])
            return
        }

        if self.type != type{
            self.page = 1
            self.type = type
        }
        fetchMovies(page: self.page, type: type) { movie in
            DispatchQueue.main.async {
                completion(movie.results)
            }
            self.page += self.page < self.totalPage ? 1 : 0
        }
        
    }
    
    
    func fetchMovies(page: Int, type: String, completion: @escaping (Movie) -> ()) {
        let urlString = "\(Constants.url)\(type)&api_key=\(Constants.apiKey)&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                self.totalPage = result.totalPages
                completion(result)
            } catch let jsonErr {
                print("fetchMovieDetail -> Failed to decode json: ", jsonErr)
            }
        }.resume()
    }
}

enum type: String, CaseIterable {
    case topRated = "top_rated?"
    case popular = "popular?"
}

