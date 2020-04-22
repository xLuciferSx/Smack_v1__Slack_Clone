//
//  MessageService.swift
//  Smack
//
//  Created by Raivis on 16/04/20.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        AF.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.error == nil {
                guard let data = response.data else { return }
                if let json = try!JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }    
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
        
    }
    
    
    func  findAllmessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        
        AF.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = try!JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                         let channelId = item["channelId"].stringValue
                         let id = item["_id"].stringValue
                         let userName = item["userName"].stringValue
                         let userAvatar = item["userAvatar"].stringValue
                         let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                     
                    }
                    print(self.messages)
                   completion(true)
                }
            } else {
                debugPrint(response.error as Any)
                completion(false)
            }
        }
        
    }
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
}
