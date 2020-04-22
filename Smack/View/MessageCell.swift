//
//  MessageCell.swift
//  Smack
//
//  Created by Raivis on 21/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
//Outlets
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStapLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStapLabel.text = finalDate
        }
    }

}
