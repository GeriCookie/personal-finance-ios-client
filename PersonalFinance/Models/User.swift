//
//  User.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class UserRegister: Codable{
    var username: String
    var email: String
    var password1: String
    var password2: String
    
    init(withUsername username: String, email: String, andPassword password: String) {
        self.username = username
        self.email = email
        self.password1 = password
        self.password2 = password
    }
}

class UserLogin: Codable {
    var username: String
    var password: String
    
    init(withUsername username: String, andPassword password: String) {
        self.username = username
        self.password = password
    }
}




