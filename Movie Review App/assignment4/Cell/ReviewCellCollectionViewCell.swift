//
//  ReviewCellCollectionViewCell.swift
//  assignment4
//
//  Created by Romil Jain on 4/22/23.
//
//Review View
import UIKit

protocol ImageClicked {
    func likeClicked(cell: ReviewCellCollectionViewCell)
    func disliked(cell: ReviewCellCollectionViewCell)
    func deleteChat(cell: ReviewCellCollectionViewCell)
}

class ReviewCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userReviewTextView: UITextView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var dislikeButtonImageView: UIImageView!
    @IBOutlet weak var deleteButtonImageView: UIImageView!
    
    var delegate: ImageClicked?
    var userID: String?
    
    override func awakeFromNib() {
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.likeImageClicked))
        likeButtonImageView.addGestureRecognizer(tapGesture1)
        likeButtonImageView.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.dislikeImageClicked))
        dislikeButtonImageView.addGestureRecognizer(tapGesture2)
        dislikeButtonImageView.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.deleteComment))
        deleteButtonImageView.addGestureRecognizer(tapGesture3)
        deleteButtonImageView.isUserInteractionEnabled = true
        deleteButtonImageView.isHidden = true
    }
    
    @objc func likeImageClicked() {                 //if user liked the movie
        delegate?.likeClicked(cell: self)
    }
    
    @objc func dislikeImageClicked() {              //if user disliked the movie
        delegate?.disliked(cell: self)
    }
    
    @objc func deleteComment() {                    //if user wants to delete review
        delegate?.deleteChat(cell: self)
    }
}
