//
//  EditProfileViewController.swift
//  Nickel!
//
//  Created by Matt Deuschle on 2/17/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

import UIKit

class EditProfileViewController: SuperViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var firstNameLabel: UITextField! //This actually encompasses the full user name
    @IBOutlet weak var handleLabel: UITextField!
    @IBOutlet weak var userRoleLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
        
    // value to hold keyboard frmae size
    var keyboard = CGRect()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Edit Profile"
        
        
        if User.sharedInstance.name != nil {
            firstNameLabel.text = User.sharedInstance.name
        }
        
        if User.sharedInstance.nickname != nil {
            handleLabel.text = User.sharedInstance.nickname
        }
        
        if User.sharedInstance.positionTitle != nil {
            userRoleLabel.text = User.sharedInstance.positionTitle
        }
        
        if User.sharedInstance.emailAddress != nil {
            emailLabel.text = User.sharedInstance.emailAddress
        }
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        // tap to choose image
        let imageTap = UITapGestureRecognizer(target: self, action: "loadImg:")
        imageTap.numberOfTapsRequired = 1
        profileImageView.userInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        
        
        //rounds the image from a square to circle
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if userDefaults.valueForKey("userPicture") != nil {
         self.profilePicFromData(userDefaults.valueForKey("userPicture") as! NSData)
        self.profileImageView.image = profilePicture
        }
        
    }
    
    // Custom Function: to hide keyboard
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    // func to call UIImagePickerController
    func loadImg (recognizer : UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //Method to finalize actions with UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        profileImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        let data = self.digitizePicture(profileImageView.image!)
        userDefaults.setValue(data, forKey: "userPicture")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // alert message function
    func alert (error: String, message : String) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: TextField Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //User pressed the save button to update the profile information
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        
        // save filled in information and send to CK
        User.sharedInstance.name = self.firstNameLabel.text
        User.sharedInstance.nickname = self.handleLabel.text
        User.sharedInstance.positionTitle = self.userRoleLabel.text
        User.sharedInstance.emailAddress = self.emailLabel.text
        
        
    }
    
}//end of class
