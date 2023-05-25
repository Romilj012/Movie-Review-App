//
//  MasterTableViewController.swift
//  assignment4
//
//  Created by Romil Jain on 4/27/23.
//

import UIKit

class MasterTableViewController: UITableViewController, NetworkOperation{
    var moviesList: Movies!
    var movieNetworkRequester = MovieNetworkRequester()
    var networkOperationSuccessfull = false


    override func viewDidLoad() {
        super.viewDidLoad()
        moviesList = Movies()
        moviesList.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.rowHeight = 300
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        let profileBarButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(showProfileScreen))
        self.navigationItem.rightBarButtonItem  = profileBarButton
    }
    
    @objc func showProfileScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "UserInfoScreen") as? UserInfoViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if networkOperationSuccessfull {
            return moviesList.movies?.count ?? 0
        } else {
            return 0
        }
        
    }
    
    func successfull() {
        networkOperationSuccessfull = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure() {
        networkOperationSuccessfull =  false
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movies", for: indexPath) as? MasterTableViewCell
        cell?.movieNameLabel.text = moviesList.movies?[indexPath.row].title ?? ""
        let posterPath = moviesList.movies?[indexPath.row].poster_path ?? ""
        movieNetworkRequester.imageFromServer(url: "w185/" + posterPath ) { (image) in
            if let posterImage = image {
                DispatchQueue.main.async {
                    cell?.movieImageView.image = posterImage
                }
            }
        }
        let votes = moviesList.movies?[indexPath.row].vote_average ?? 0
        cell?.movieRatingLabel.text = "⭐️\(votes)"
        return cell!
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            moviesList.movies?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = moviesList.movies?[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
            detailViewController.movie = movie
            let reviewViewController = storyboard.instantiateViewController(withIdentifier: "UserReview") as! UserReviewViewController
            reviewViewController.movie = movie
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [detailViewController, reviewViewController]
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }

}

