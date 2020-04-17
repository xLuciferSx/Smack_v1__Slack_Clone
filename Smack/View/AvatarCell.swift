//
//  AvatarCell.swift
//  Smack
//
//  Created by Raivis on 17/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView() 
        
    }
    
    func setupView() {
        
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
