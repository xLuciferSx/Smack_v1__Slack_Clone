//
//  Channel.swift
//  Smack
//
//  Created by Raivis Olehno on 4/17/20.
//  Copyright © 2020 Jonny B. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
