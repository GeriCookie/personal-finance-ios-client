//
//  CacheService.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class CacheService {
    
    let userDefaults: UserDefaults
    
    var authToken: String {
        get {
            if let token = userDefaults.value(forKey: TOKEN_KEY) {
                return token as! String
            }
            else {
                return ""
            }
        }
        set {
            userDefaults.set(newValue, forKey: TOKEN_KEY)
        }
    }

    var username: String {
        get {
            return userDefaults.value(forKey: USERNAME_KEY) as! String
        }
        set {
            userDefaults.set(newValue, forKey: USERNAME_KEY)
        }
    }
    
    init() {
        userDefaults = .standard
    }
    
}
