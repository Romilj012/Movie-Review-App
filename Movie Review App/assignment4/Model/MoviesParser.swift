//
//  moviesParser.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import Foundation


struct MoviesParser {
    func decodeJson(data: Data) -> MovieList? {
        var movieList: MovieList?
        do {
            movieList = try JSONDecoder().decode(MovieList.self, from: data)
        } catch {
            print("===========> Error Parsing Data <=============")
        }
        return movieList
    }
}
