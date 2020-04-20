//
//  LoginVC.swift
//  Smack
//
//  Created by Raivis on 14/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
  view.addGestureRecognizer(tap)
    }
    
    @objc override func dismissKeyboard() {
      view.endEditing(true)
    }

    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameText.text , usernameText.text != nil else {return}
        guard let password = passwordText.text , passwordText.text != nil else {return}
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func setupView(){
        spinner.isHidden = true
        usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceHolder])
        passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceHolder])
          hideKeyboardWhenTappedAround()
    }
    
}

