//
//  ViewController.swift
//  MyMovieList
//
//  Created by Romil Jain on 3/20/23.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingImageView1: UIImageView!
    @IBOutlet weak var movieRatingImageView2: UIImageView!
    @IBOutlet weak var movieRatingImageView3: UIImageView!
    @IBOutlet weak var movieRatingImageView4: UIImageView!
    @IBOutlet weak var movieRatingImageView5: UIImageView!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieReleaseDateValueLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    var movieNetworkRequester = MovieNetworkRequester()
    var movie: Movie?
    var movieRating = MovieRating()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            appdelegate.detailViewController =  self
        }
        self.updateAllView()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movie == nil {
            return 1
        } else {
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieImage", for: indexPath) as? MovieCollectionViewCell
        if movie != nil {
            if indexPath.row == 0 {
                let posterPath = movie?.backdrop_path ?? ""
                movieNetworkRequester.imageFromServer(url: "w500/" + posterPath ) { (image) in
                    if let posterImage = image {
                        DispatchQueue.main.async {
                            cell?.movieImage.image = posterImage
                        }
                    }
                }
            } else {
                let posterPath = movie?.poster_path ?? ""
                movieNetworkRequester.imageFromServer(url: "w185/" + posterPath ) { (image) in
                    if let posterImage = image {
                        DispatchQueue.main.async {
                            cell?.movieImage.image = posterImage
                        }
                    }
                }
            }
        } else {
            cell?.movieImage.image = UIImage(named: "nik")
        }
        return cell!
    }
    
    func updateAllView() {
        movieCollectionView.reloadData()
        movieReleaseDateValueLabel.text = movie?.release_date ?? ""
        movieOverviewLabel.text = movie?.overview ?? ""
        movieReleaseDateLabel.text = "Date of Release"
        movieNameLabel.text = movie?.title
        self.updateRatingBar()
    }
    
    //Star Rating
    func updateRatingBar() {
        let offsetOfFullStar = movieRating.calculateOffsetOFFullStar(rating: movie?.vote_average ?? 0.0)
        var count = 1
        while count != 6 {
            let ratingImageView = getRatingImageViewFor(position: count)
            if movieRating.shouldSetFullStarFor(ImageViewPosition: ratingImageView, offsetOFFullStar: offsetOfFullStar) {
                ratingImageView.image = UIImage(systemName: "star.fill")
            } else if movieRating.shouldSetHalfStarFor(ImageViewPosition: ratingImageView, offsetOFFullStar: offsetOfFullStar) {
                ratingImageView.image = UIImage(systemName: "star.leadinghalf.fill")
            } else if movieRating.shouldSetEmptyStarFor(ImageViewPosition: ratingImageView, offsetOFFullStar: offsetOfFullStar) {
                ratingImageView.image = UIImage(systemName: "star")
            }
            count += 1
        }
    }
    
    func getRatingImageViewFor(position: Int) -> UIImageView {
        switch position {
        case 1:
            movieRatingImageView1.isHidden = false
            return movieRatingImageView1
        case 2:
            movieRatingImageView2.isHidden = false
            return movieRatingImageView2
        case 3:
            movieRatingImageView3.isHidden = false
            return movieRatingImageView3
        case 4:
            movieRatingImageView4.isHidden = false
            return movieRatingImageView4
        case 5:
            movieRatingImageView5.isHidden = false
            return movieRatingImageView5
        default:
            return movieRatingImageView1
        }
    }

}
