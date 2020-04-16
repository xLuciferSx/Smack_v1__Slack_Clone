//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Raivis on 14/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateAccountVC: UIViewController {
    
    
   //Outlets
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
    }
 
    @IBAction func closedPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTextField.text , emailTextField.text != "" else { return }
        guard let pass = passwordTextField.text , passwordTextField.text !=  "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion:  {
                    (success) in
                    if success {
                        print("Logged in user!", AuthService.instance.authToken)
                    }
                })
            
        }
        }
        
        
    }
    
    
    @IBAction func picAvatarPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func pickBackgroundColorPressed(_ sender: Any) {
    }
  
    

}
 
extension  UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
