//
//  ChannelVC.swift
//  Smack
//
//  Created by Raivis on 14/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

      // cell.layer.backgroundColor = UIColor.clear.cgColor
      // cell.backgroundColor = .clear
       tableView.layer.backgroundColor = UIColor.clear.cgColor
       tableView.backgroundColor = .clear
    }


}
