//
//  UserInfoViewController.swift
//  assignment4
//
//  Created by Romil Jain on 4/19/23.
//
//Profile view of User
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class UserInfoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userScrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.sharedInstances.fetchUserInfo()
        userNameTextField.delegate = self
        userLastNameTextField.delegate = self
        userPhoneNumberTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onResetClicked))
        userImageView.addGestureRecognizer(tapGesture)
        userImageView.isUserInteractionEnabled = true
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataBase.sharedInstances.getUserImage { (image) in
            if let userImage = image {
                DispatchQueue.main.async {
                    self.userImageView.image = userImage
                    self.userNameTextField.text = DataBase.sharedInstances.userName ?? ""
                    self.userLastNameTextField.text = DataBase.sharedInstances.userLastName ?? ""
                    self.userPhoneNumberTextField.text = DataBase.sharedInstances.phoneNumber ?? ""
                }
            }
        }
    }
    
    @objc func onResetClicked() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage  {
            self.userImageView.image = image
        }
    }
    
    @IBAction func userClickedContinue(_ sender: UIButton) {
        let username = userNameTextField.text ?? ""
        let userLastName = userLastNameTextField.text ?? ""
        let userPhoneNo = userPhoneNumberTextField.text ?? ""
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        request?.displayName = username
        request?.commitChanges(completion: { (error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    self.updationUnsuccessfull()
                }
            }
        })
        DispatchQueue.main.async {
            DataBase.sharedInstances.updateUserDetails(name: username, lastName: userLastName, phoneNo: userPhoneNo)
            DataBase.sharedInstances.uploadUserImage(image: self.userImageView.image!)
            self.launchMoviesScreen()
        }
    }
    
    func updationUnsuccessfull() {
        let alert = UIAlertController(title: "Updation Unsuccessfull", message: "Please try after some time", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func launchMoviesScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "Movies") as? MasterTableViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }

}
