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
    
    func setBalanceType(type: IncomeOrExpense) {
        userDefaults.set(type.rawValue, forKey: BALANCE_TYPE_KEY)
    }
    
    func setBalanceType(type: BudgetOrSavings) {
        userDefaults.set(type.rawValue, forKey: BALANCE_TYPE_KEY)
    }
    
    func getBalanceType() -> IncomeOrExpense? {
        let typeString = userDefaults.value(forKey: BALANCE_TYPE_KEY) as! String
        return IncomeOrExpense(rawValue: typeString)
    }
    
    func getBalanceType() -> BudgetOrSavings? {
        let typeString = userDefaults.value(forKey: BALANCE_TYPE_KEY) as! String
        return BudgetOrSavings(rawValue: typeString)
    }
}
