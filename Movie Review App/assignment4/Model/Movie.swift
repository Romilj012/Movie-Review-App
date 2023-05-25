//
//  Movie.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import Foundation

struct Movie: Decodable {
    
    let adult: Bool
    let backdrop_path: String
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let title: String
    let vote_average: Float
    let id: Int64
}
