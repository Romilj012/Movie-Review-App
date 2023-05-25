//
//  UserReviewViewController.swift
//  assignment4
//
//  Created by Romil Jain on 4/22/23.
//

import UIKit
import Firebase

enum LikeButtonImage: String {
    case noReviewLike = "NorLike"
    case like = "Like"
    case dislike = "Dislike"
    case noReviewDislike = "NorDislike"
    
    public var ImageValue: Int {
        switch self {
        case .dislike:
            return 2
        case .like:
            return 1
        default:
            return 0
        }
    }
}

class UserReviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ImageClicked, ReviewFetchComplete, UITextViewDelegate {
  
    @IBOutlet weak var userReviewTextView: UITextView!
    @IBOutlet weak var userReviewCollectionView: UICollectionView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userReviewCollectionView.delegate = self
        userReviewCollectionView.dataSource = self
        DataBase.sharedInstances.delegate = self
        userReviewTextView.delegate = self
        DataBase.sharedInstances.fetchUserReview(movieID: movie?.id ?? 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userReviewTextView.layer.borderWidth = 1
        userReviewTextView.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationItem.title = "Reviews"
    }
    

    @IBAction func userTappedSubmit(_ sender: Any) {
        let auth = Auth.auth().currentUser?.email ?? ""
        DataBase.sharedInstances.updateUserReview(userName: auth, reviewText: userReviewTextView.text ?? "", movieID: movie?.id ?? 0)
        DataBase.sharedInstances.fetchUserReview(movieID: movie?.id ?? 0)
        userReviewTextView.text = ""
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataBase.sharedInstances.movieReview.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentUser = Auth.auth().currentUser?.uid
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCellCollectionViewCell
        let userReview = DataBase.sharedInstances.movieReview[indexPath.row]
        cell?.userNameLabel.text = userReview.Reviews?.userName
        cell?.userReviewTextView.text = userReview.Reviews?.userReview
        cell?.userReviewTextView.layer.borderWidth = 2
        cell?.userReviewTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        cell?.likeButtonImageView.image = UIImage(named: LikeButtonImage.noReviewLike.rawValue)
        cell?.dislikeButtonImageView.image = UIImage(named: LikeButtonImage.noReviewDislike.rawValue)
        cell?.userID = userReview.userID
        for (userId, likedValue) in userReview.Reviews?.userLikedID ?? [:] {
            if userId == currentUser {
                if likedValue == 2 {
                    cell?.dislikeButtonImageView.image = UIImage(named: LikeButtonImage.dislike.rawValue)
                } else {
                    cell?.likeButtonImageView.image = UIImage(named: LikeButtonImage.like.rawValue)
                }
            }
        }
        if (userReview.userID == currentUser) {
            cell?.deleteButtonImageView.isHidden = false
        } else {
            cell?.deleteButtonImageView.isHidden = true
        }
        cell?.delegate = self
        return cell!
    }

    func likeClicked(cell: ReviewCellCollectionViewCell) {
        DispatchQueue.main.async {
            DataBase.sharedInstances.updateUserLike(likedUserID: cell.userID ?? "", movieID: self.movie?.id ?? 0, likeValue: LikeButtonImage.like.ImageValue)
            cell.likeButtonImageView.image = UIImage(named: LikeButtonImage.like.rawValue)
            cell.dislikeButtonImageView.image = UIImage(named: LikeButtonImage.noReviewDislike.rawValue)
            DataBase.sharedInstances.fetchUserReview(movieID: self.movie?.id ?? 0)
        }
    }
    
    func disliked(cell: ReviewCellCollectionViewCell) {
        DispatchQueue.main.async {
            DataBase.sharedInstances.updateUserLike(likedUserID: cell.userID ?? "", movieID: self.movie?.id ?? 0, likeValue: LikeButtonImage.dislike.ImageValue)
            cell.dislikeButtonImageView.image = UIImage(named: LikeButtonImage.dislike.rawValue)
            cell.likeButtonImageView.image = UIImage(named: LikeButtonImage.noReviewLike.rawValue)
            DataBase.sharedInstances.fetchUserReview(movieID: self.movie?.id ?? 0)
            DataBase.sharedInstances.fetchUserReview(movieID: self.movie?.id ?? 0)
        }
    }
    
    func deleteChat(cell: ReviewCellCollectionViewCell) {
        DataBase.sharedInstances.deleteReview(movieID: movie?.id ?? 0)
        DataBase.sharedInstances.fetchUserReview(movieID: movie?.id ?? 0)
    }
    
    func allReviewFetched() {
        userReviewCollectionView.reloadData()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
