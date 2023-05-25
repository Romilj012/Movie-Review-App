//
//  MovieReview.swift
//  assignment4
//
//  Created by Romil Jain on 4/22/23.
//

import Foundation

class UsersComment {
    var userName: String = ""
    var userReview: String = ""
    var userLikedID: [String: Int] = [:]
}

class MovieReview {
    var userID: String = ""
    var Reviews:UsersComment?
}
