//
//  BalanceItem.swift
//  PersonalFinance
//
//  Created by Cookie on 30.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class SavingsGoal: Codable {
    var endDate: String?
    var amount: String?
    var completed: Bool?
    
    init(withAmount amount: String, endDate: String, andCompleted completed: Bool) {
        self.amount = amount
        self.endDate = endDate
        self.completed = completed
    }
    
    enum CodingKeys: String, CodingKey {
        case endDate = "end_date"
    }
}
