//
//  DataBase.swift
//  assignment4
//
//  Created by Romil Jain on 4/20/23.
//
//Creating realtime database
import Foundation
import Firebase
//Fectching all reviews
protocol ReviewFetchComplete {
    func allReviewFetched()
}

class DataBase {
    
    static let sharedInstances = DataBase()
    var db = Database.database().reference()
    var storage = Storage.storage().reference()
    var userID = Auth.auth().currentUser?.uid ?? ""
    var movie: Movie!
    var movieReview: [MovieReview] = []
    var delegate: ReviewFetchComplete?
    var userImage: UIImage?
    var userName: String?
    var userLastName: String?
    var phoneNumber: String?
    
    //To find 
    func updateUserDetails(name: String, lastName: String, phoneNo: String) {
        db.child("Users").child(userID).child("userDetails").child("userName").setValue(name)
        db.child("Users").child(userID).child("userDetails").child("userLastName").setValue(lastName)
        db.child("Users").child(userID).child("userDetails").child("phoneNo").setValue(phoneNo)
    }
    
    func initAllFirebase() {
        db = Database.database().reference()
        storage = Storage.storage().reference()
        userID = Auth.auth().currentUser?.uid ?? ""
    }
    
    func uploadUserImage(image: UIImage) {
        userImage = image
        let ref = storage.child("Users").child(userID).child("userDetails").child("image.png")
        if let data = image.pngData() {
            ref.putData(data)
        }
    }
    
    func fetchUserInfo() {
        if userID != "" {
            db.child("Users").child(userID).child("userDetails").observeSingleEvent(of: .value) { (dataSnapshot) in
                if let jsonValue = dataSnapshot.value as? [String:Any] {
                    self.userName = jsonValue["userName"] as? String ?? ""
                    self.userLastName = jsonValue["userLastName"] as? String ?? ""
                    self.phoneNumber = jsonValue["phoneNo"] as? String ?? ""
                }
            }
        }
    }
    
    func getUserImage(closure: @escaping (UIImage?) -> Void) {
        if userID != "" {
            let ref = storage.child("Users/\(userID)/userDetails/image.png")
            ref.downloadURL { (url, error) in
                if let erro1 = error {
                    print(erro1)
                    closure(nil)
                } else {
                    if let urlData = url {
                        let request = URLRequest(url: urlData.absoluteURL)
                        let session = URLSession.shared
                        let task = session.dataTask(with: request) { (data, response, error) in
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                closure(image)
                            } else {
                                closure(nil)
                            }
                        }
                        task.resume()
                    } else {
                        closure(nil)
                    }
                }
            }
        }
    }
    
    func updateUserReview(userName: String, reviewText: String, movieID: Int64) {
        if userID != "" {
            db.child("Users").child("MovieReview").child("\(movieID)").child(userID).child("userName").setValue(userName)
            db.child("Users").child("MovieReview").child("\(movieID)").child(userID).child("Review").setValue(reviewText)
        }
        
    }
    
    func updateUserLike(likedUserID: String, movieID: Int64, likeValue: Int) {
        if userID != "" {
            db.child("Users").child("MovieReview").child("\(movieID)").child(likedUserID).child("UserLiked").child(userID).setValue(likeValue)
        }
    }
    
    func deleteReview(movieID: Int64) {
        if userID != "" {
            db.child("Users").child("MovieReview").child("\(movieID)").child(userID).removeValue()
        }
        
    }
    //Fectching MovieReviews for particular user
    func fetchUserReview(movieID: Int64) {
        if userID != "" {
            db.child("Users").child("MovieReview").child("\(movieID)").observeSingleEvent(of: .value) { (DataSnapshot) in
                if let jsonValue = DataSnapshot.value as? [String: Any] {
                    var reviewss: [MovieReview] = []
                    for (usersID, reviewInformation) in jsonValue {
                        let review = MovieReview()
                        review.userID = usersID
                        let UsersReview = UsersComment()
                        if let reviewData = reviewInformation as? [String: Any] {
                            if let reviews = reviewData["Review"] as? String {
                                UsersReview.userReview = reviews
                            }
                            if let uname = reviewData["userName"] as? String {
                                UsersReview.userName = uname
                            }
                            if let userLikedData = reviewData["UserLiked"] as? [String: Int] {
                                var userLikedComment: [String: Int] = [:]
                                for (userID, likedValue) in userLikedData {
                                    userLikedComment[userID] = likedValue
                                }
                                UsersReview.userLikedID = userLikedComment
                            }
                        }
                        review.Reviews = UsersReview
                        reviewss.append(review)
                    }
                    self.movieReview = reviewss
                    self.delegate?.allReviewFetched()
                } else {
                    self.movieReview = []
                    self.delegate?.allReviewFetched()
                }
            }
        }
        
    }
    
}
