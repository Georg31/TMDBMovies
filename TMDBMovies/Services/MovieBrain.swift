//
//  MovieBrain.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/9/21.
//

import UIKit

class MovieBrain: NSObject{
    
    private weak var collectionV: UICollectionView!
    private weak var seg: UISegmentedControl!
    private weak var parent: UIViewController!
    
    static let br = MovieBrain()
    var db = Dbase.DB
    var service = Service.shared
    var movies = [Movies]()
    var favMovies = [Movies]()
    var ind: Int!
    
    struct Config {
        var c: UICollectionView
        var s: UISegmentedControl
        var p: UIViewController
    }
    private static var config:Config?
    class func setup(_ config:Config){
        MovieBrain.config = config
    }
    private override init() {
        guard let config = MovieBrain.config else {
            fatalError("Error - you must call setup before accessing MySingleton.shared")
        }
        collectionV = config.c
        seg = config.s
        parent = config.p
    }
    
    
    func config(){
        collectionV.delegate = parent as? UICollectionViewDelegate
        collectionV.dataSource = parent as? UICollectionViewDataSource
        collectionV.register(UINib(nibName: Constants.movieCell, bundle: nil), forCellWithReuseIdentifier: Constants.movieCell)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.connection), object: nil, queue: nil) { _ in
            self.presentAlert()
        }
        filter()
    }
    
    func presentAlert(){
        let alert = UIAlertController(title: "No Connection", message: "Check Your Connectivity", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        parent.present(alert, animated: true, completion: nil)
    }
    
    func fetchData(type: String = Constants.topRated){
        service.fetchNextPage(type: type) { [self] res in
            movies += res.getMovies
            checkFavs()
            collectionV.reloadData()
        }
    }
    
    func checkFavs(){
        favMovies = db.getMovies().getFavs
        for (ind, item) in movies.enumerated() {
            if favMovies.contains(item)
            {movies[ind].favourite = true}
        }
    }
    
    func filter(){
        movies = []
        collectionV.reloadData()
        parent.title = seg.titleForSegment(at: seg.selectedSegmentIndex)
        if seg.selectedSegmentIndex == 2 {
            favMovies = []
            favMovies += db.getMovies().getFavs
            service.page = 1
            movies = favMovies
            collectionV.reloadData()
            return
        }
        fetchData(type: type.allCases[seg.selectedSegmentIndex].rawValue)
        collectionV.setContentOffset(.zero, animated: true)
    }
}


extension MovieBrain: Favouties{
    func removeFav(movie: Movies) {
        if let ind = favMovies.firstIndex(of: movie){
            favMovies.remove(at: ind)
            db.deleteMovie(movie: db.getMovies()[ind])
        }
        if seg.selectedSegmentIndex == 2{
            favMovies = db.getMovies().getFavs
            movies = favMovies
            collectionV.reloadData()
        }
    }
    
    func addToFav(movie: Movies) {
        db.SaveMovie(movie)
    }
    
}
