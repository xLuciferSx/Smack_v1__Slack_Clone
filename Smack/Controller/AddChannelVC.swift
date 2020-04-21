//
//  AddChannelVC.swift
//  Smack
//
//  Created by Raivis on 21/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 setupView()
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    }
