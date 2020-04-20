//
//  Channel.swift
//  Smack
//
//  Created by Raivis on 20/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
