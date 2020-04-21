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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

func getMessages(){
    
    guard let channelId = MessageService.instance.selectedChannel?.id else { return }
    MessageService.instance.findAllmessagesForChannel(channelId: channelId) { (success) in
        
    }
    
}
