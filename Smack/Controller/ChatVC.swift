//
//  ChatVC.swift
//  Smack
//
//  Created by Raivis on 16/04/20.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit
import SocketIO
import Starscream

class ChatVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typingUsersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    //Variables
    var isTyping = false
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.bindToKeyboard()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableViewAutomaticDimension
            sendButton.isHidden = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
            view.addGestureRecognizer(tap)
            menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
            SocketService.instance.getChatMessage { (success) in
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
            
            SocketService.instance.getTypingUsers{ (typingUsers) in
                guard let channelId = MessageService.instance.selectedChannel?.id else {return}
                var names = ""
                var numberOfTypers = 0
                
                for (typingUser, channel) in typingUsers {
                    if typingUser != UserDataService.instance.name && channel == channelId {
                        if names == "" {
                            names = typingUser
                        } else {
                            names = "\(names), \(typingUser)"
                        }
                        numberOfTypers += 1
                    }
                }
                
                if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                    var verb = "is"
                    if numberOfTypers > 1 {
                        verb = "are"
                    }
                    self.typingUsersLabel.text = "\(names) \(verb) typing a message"
                } else {
                    self.typingUsersLabel.text = ""
                }
    }
            
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
                onLoginGetMessages()
            } else {
                channelNameLbl.text = "Please Log In"
                tableView.reloadData()
            }
        }
        
        @objc func channelSelected(_ notif: Notification) {
            updateWithChannel()
        }
        
        @objc func handleTap() {
            view.endEditing(true)
        }
        
        func updateWithChannel() {
            let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
            channelNameLbl.text = "#\(channelName)"
            getMessages()
        }
        
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId )
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
            @IBAction func sendMessagePressed(_ sender: Any) {
                if AuthService.instance.isLoggedIn {
                    guard let channelId = MessageService.instance.selectedChannel?.id else {return}
                    guard let message = messageTextBox.text else {return}
        
                    SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                        if success {
                            self.messageTextBox.text = ""
                            self.messageTextBox.resignFirstResponder()
                            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        
                        }
                    }
                }
        
            }
        
        
        func onLoginGetMessages() {
            MessageService.instance.findAllChannel { (success) in
                if success {
                    if MessageService.instance.channels.count > 0 {
                        MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                        self.updateWithChannel()
                    } else {
                        self.channelNameLbl.text = "No channels yet!"
                    }
                }
            }
        }
        
        func getMessages() {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            MessageService.instance.findAllmessagesForChannel(channelId: channelId) { (success) in
                if success {
                    self.tableView.reloadData()
                }
            }
        }
        
    
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
                let message = MessageService.instance.messages[indexPath.row]
                cell.configureCell(message: message)
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return MessageService.instance.messages.count
            
        }
         
    }
