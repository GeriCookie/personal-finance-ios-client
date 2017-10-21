//
//  Expense.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class Expense: Codable {
    var category: Category
    var amount: String
    var date: String
    
    init(with category: Category, amount: String, date: String){
        self.category = category
        self.amount = amount
        self.date = date
    }
}
