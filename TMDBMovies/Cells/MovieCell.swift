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
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var imgView: UIImageView!
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
        addRatingView()
        ratingLabel.text = String(movie.voteAverage)
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
    
    func percentToRadians() -> Double {
        return 2 * Double.pi / 10.0 * movie.voteAverage
    }
    
    func addRatingView(){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: ratingView.bounds.midX,y: ratingView.bounds.midY), radius: CGFloat(20), startAngle: CGFloat(-Double.pi / 2), endAngle:CGFloat(-1.55 + percentToRadians()), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = .none
        shapeLayer.strokeColor = #colorLiteral(red: 0.1292955875, green: 0.7561361194, blue: 0.4459108114, alpha: 1)
        shapeLayer.lineWidth = 3.0
    
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: ratingView.bounds.midX,y: ratingView.bounds.midY), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = circlePath2.cgPath
        shapeLayer2.fillColor = .none
        shapeLayer2.strokeColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        shapeLayer2.lineWidth = 3.0
        ratingView.layer.addSublayer(shapeLayer2)
        ratingView.layer.addSublayer(shapeLayer)
    }
    
}
