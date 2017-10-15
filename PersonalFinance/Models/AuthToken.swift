//
//  AuthToken.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class AuthToken: Codable {
    var key: String?
    
    init(withAuthKey authKey: String) {
        self.key = authKey
    }
}

