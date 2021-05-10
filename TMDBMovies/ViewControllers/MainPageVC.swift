//
//  ViewController.swift
//  TMDBMovies
//
//  Created by George Digmelashvili on 5/7/21.
//

import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    
    
    var br: MovieBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieBrain.setup(MovieBrain.Config(c: collectionView, s: filterSegment, p: self))
        br = MovieBrain.br
        br.config()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    @IBAction func filterMovies(_ sender: UISegmentedControl) {
        br.filter()
    }
    
}


extension MainPageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        br.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieCell, for: indexPath) as! MovieCell
        //if br.movies.count < indexPath.row {return cell}
        cell.config(movie: br.movies[indexPath.row])
        cell.del = br
        if indexPath.row == br.movies.count - 3 && filterSegment.selectedSegmentIndex != 2{br.fetchData(type: type.allCases[filterSegment.selectedSegmentIndex].rawValue)}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        br.ind = indexPath.row
        self.performSegue(withIdentifier: Constants.segueId, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2.02, height: collectionViewWidth/1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueId {
            if let vc = segue.destination as? DetailsVC {
                vc.movie = br.movies[br.ind]
                vc.br = self.br
            }
        }
    }
}


