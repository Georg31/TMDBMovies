//
//  DetailsVC.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/8/21.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    var movie: Movies!
    var del: Favouties?
    var br: MovieBrain!

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    @IBAction func favButton(_ sender: UIButton) {
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
    
    func config(){
        del = br
        imgView.image = movie.img
        originalTitleLabel.text = movie.originalTitle
        ratingLabel.text = "Rating: \(String(movie.voteAverage))"
        releaseDateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        self.title = movie.title
        if movie.favourite{
            favButton.setImage(UIImage(named: "iconFill"), for: .normal)
        }
    }

}
