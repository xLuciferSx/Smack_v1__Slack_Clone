//
//  ProfileVC.swift
//  Smack
//
//  Created by Raivis on 20/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
//Outlets
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }



    @IBAction func closeModalPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func logoutPressed(_ sender: Any) {
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
         userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_: )))
        backgroundView.addGestureRecognizer(closeTouch)
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
