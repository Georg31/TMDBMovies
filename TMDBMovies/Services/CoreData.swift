//
//  CoreData.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/9/21.
//

import Foundation
import CoreData

class Dbase{
    
    static let DB = Dbase()
    private init(){}
    
    func SaveMovie(_ movie: Movies) {
        let context = AppDelegate.coreDataContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserMovies", in: context)
        let movieD = UserMovies(entity: entityDescription!, insertInto: context)
        movieD.favourite = movie.favourite
        movieD.iD = Int64(movie.id)
        movieD.originalTitle = movie.originalTitle
        movieD.poster = movie.img?.pngData()
        movieD.releaseDate = movie.releaseDate
        movieD.review = movie.overview
        movieD.title = movie.title
        movieD.voteAvarage = movie.voteAverage
        do {
            try context.save()
        } catch {}
    }
    
    
    func getMovies() -> [UserMovies]{
        let context = AppDelegate.coreDataContainer.viewContext
        let request: NSFetchRequest<UserMovies> = UserMovies.fetchRequest()
        var movies = [UserMovies]()
        do {
            let result = try context.fetch(request)
            
            movies = result
            
        } catch {}
        return movies
    }
    
    func deleteMovie(movie: UserMovies){
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(movie)
        do {
            try context.save()
        }catch{}
    }
    
}
