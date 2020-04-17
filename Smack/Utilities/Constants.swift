//
//  Constants.swift
//  Smack
//
//  Created by Raivis on 14/04/2020.
//  Copyright © 2020 Raivis Olehno. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (_ Success:Bool) -> ()

//URL_CONSTANTS

let BASE_URL = "https://slackclo.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


let HEADER: HTTPHeaders? = HTTPHeaders(["Content-Type": "application/json"])
let HEADERR: HTTPHeaders? = HTTPHeaders(["Authorization" : "Bearer \(AuthService.instance.authToken)" , "Content-Type": "application/json"])




