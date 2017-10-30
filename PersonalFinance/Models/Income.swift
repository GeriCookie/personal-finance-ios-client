//
//  Income.swift
//  PersonalFinance
//
//  Created by Cookie on 19.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class Income: Codable {
    var id: Int?
    var category: Category
    var amount: String
    var date: String
    
    init(with category: Category, amount: String, date: String){
        self.category = category
        self.amount = amount
        self.date = date
    }
}

struct IncomeByDate: Codable {
    let amountPerCategory: Double
    let categoryName: String
    let categoryColor: String
    
    enum CodingKeys: String, CodingKey {
        case amountPerCategory = "amount_per_category"
        case categoryName = "category__name"
        case categoryColor = "category__color"
        
    }
}
