//
//  MovieNetworkRequester.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import Foundation
import UIKit

struct MovieNetworkRequester {

    let movieURL = "http://api.themoviedb.org/3/movie/upcoming?api_key=052bb5dd2da90d7827d1758364f1f92a"
    let headers = [
      "cache-control": "no-cache",
    ]
    let jsonParser = MoviesParser()
    
    func performNetworkRequest(closure: @escaping (MovieList?) -> Void) {
        let request = NSMutableURLRequest(url: URL(string: movieURL)! ,
                                          cachePolicy: .returnCacheDataElseLoad,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if (error != nil) {
                print("========>ERROR<==========")
            } else {
                if let responseData = data {
                    closure(jsonParser.decodeJson(data: responseData))
                }
            }
        }
        dataTask.resume()
    }
    
    func imageFromServer(url: String, closure: @escaping (UIImage?) -> Void) {
        let baseURL = "http://image.tmdb.org/t/p/" + url
        if let CompleteURL = URL(string: baseURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: CompleteURL) {
                    DispatchQueue.main.async {
                        closure(UIImage(data: data))
                    }
                }
            }
        }
    }

    
}
