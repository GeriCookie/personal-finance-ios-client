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
    
    init(with category: Category, amount: String, date: String) {
        self.category = category
        self.amount = amount
        self.date = date
    }
}

struct ExpenseByDate: Codable {
    let amountPerCategory: Double
    let categoryName: String
    let categoryColor: String
    
    enum CodingKeys: String, CodingKey {
        case amountPerCategory = "amount_per_category"
        case categoryName = "category__name"
        case categoryColor = "category__color"
        
    }
}
