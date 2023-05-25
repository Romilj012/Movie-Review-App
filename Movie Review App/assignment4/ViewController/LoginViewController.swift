//
//  LoginViewController.swift
//  assignment4
//
//  Created by Romil Jain on 4/19/23.
//

//User login view or Registration view
import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    var userEmail = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsloggedIn()
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
    }
    
    func checkIfUserIsloggedIn() {
        if Auth.auth().currentUser != nil {
            showMoviesViewController()
        }
    }

    @IBAction func userClickedLogin(_ sender: UIButton) {
        if checkIfInputFieldIsNotEmpty() {
            loginUser()
        }
    }
    
    func loginUser () {                     //User Login
        let _ = Auth.auth().createUser(withEmail: userEmail, password: password) { (result, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    DispatchQueue.main.async {
                        self.LoginUnsuccessfullAlert()
                    }
                } else {
                    print(result?.additionalUserInfo?.username ?? "")
                    self.LoginSuccessfull()
                }
            }
        }
    }
    
    func LoginSuccessfull() {                           //Checking if the user login is successful
        DataBase.sharedInstances.initAllFirebase()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "UserInfoScreen") as? UserInfoViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func showMoviesViewController() {                       //Showing movie list
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "Movies") as? MasterTableViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func checkIfInputFieldIsNotEmpty() -> Bool {
        userEmail = userNameTextField.text ?? ""
        password = userPasswordTextField.text ?? ""
        if userEmail != "" && password != "" {
            return true
        }
        showAlertMissingData()
        return false
    }
    
    func showAlertMissingData() {
        let alert = UIAlertController(title: "Missing Data", message: "Please enter all the information", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func LoginUnsuccessfullAlert() {            //If login was unsuccessful
        let alert = UIAlertController(title: "Login Unsuccessfull", message: "Please Login After Sometime", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }

}
