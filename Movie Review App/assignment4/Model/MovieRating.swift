//
//  MovieRating.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import Foundation
import UIKit

class MovieRating {
    
    func calculateOffsetOFFullStar(rating: Float) -> (Int) {
        return (Int(rating/2))
    }
    
    func shouldSetFullStarFor(ImageViewPosition: UIImageView, offsetOFFullStar: Int) -> Bool {
        if ImageViewPosition.tag <= offsetOFFullStar && offsetOFFullStar != 0{
            return true
        }
        return false
    }
    
    func shouldSetHalfStarFor(ImageViewPosition: UIImageView, offsetOFFullStar: Int) -> Bool {
        if ImageViewPosition.tag == offsetOFFullStar + 1 && offsetOFFullStar != 0 {
            return true
        }
        return false
    }
    
    func shouldSetEmptyStarFor(ImageViewPosition: UIImageView, offsetOFFullStar: Int) -> Bool {
        if ImageViewPosition.tag > offsetOFFullStar + 1 || offsetOFFullStar == 0 {
            return true
        }
        return false
    }
}
