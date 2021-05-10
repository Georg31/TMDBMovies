//
//  MovieCell.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/8/21.
//

import UIKit

protocol Favouties {
    func addToFav(movie: Movies)
    func removeFav(movie: Movies)
}

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var del: Favouties?
    var movie: Movies!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @IBAction func addTofavourites(_ sender: UIButton) {
        movie.favourite.toggle()
        if movie.favourite{
            sender.setImage(UIImage(named: "iconFill"), for: .normal)
            del?.addToFav(movie: self.movie)
        }
        else{
            sender.setImage(UIImage(named: "icon"), for: .normal)
            del?.removeFav(movie: self.movie)
        }
        
        
    }
    
    
    func config(movie: Movies){
        self.movie = movie
        titleLabel.text = movie.title
        if movie.favourite {
            favouriteButton.setImage(UIImage(named: "iconFill"), for: .normal)
        }
        else{ favouriteButton.setImage(UIImage(named: "icon"), for: .normal)}
        
        if let img = movie.img {
            imgView.image = img
        }
        else{
            movie.posterPath.downloadImage { img in
                DispatchQueue.main.async {
                    self.movie.img = img
                    self.imgView.image = img
                }
            }
        }
       
    }
    
}
