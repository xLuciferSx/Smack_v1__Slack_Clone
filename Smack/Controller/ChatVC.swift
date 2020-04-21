//
//  ChatVC.swift
//  Smack
//
//  Created by Raivis on 16/04/20.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //get channels
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
             }
    
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannell()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    @objc func channelSelected(_ notif:Notification) {
        updateWithChannell()
    }
    
    func updateWithChannell(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
        }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTextBox.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                    
                }
            }
        }
        
    }
    
}


func getMessages(){
    
    guard let channelId = MessageService.instance.selectedChannel?.id else { return }
    MessageService.instance.findAllmessagesForChannel(channelId: channelId) { (success) in
        
    }
    
}


