//
//  Movies.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import Foundation

class MovieList: Decodable {
    let results: [Movie]?
}

protocol NetworkOperation {
    
    func successfull()
    
    func failure()
}

class Movies {
    
    var movies: [Movie]?
    let movieNetworkRequester = MovieNetworkRequester()
    var delegate: NetworkOperation?
    
    init() {
        movieNetworkRequester.performNetworkRequest { (movieList) in
            if let movieLists = movieList {
                self.movies = movieLists.results
                self.delegate?.successfull()
            } else {
                self.delegate?.failure()
            }
        }
    }
}


