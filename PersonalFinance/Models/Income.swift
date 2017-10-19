//
//  Income.swift
//  PersonalFinance
//
//  Created by Cookie on 19.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class Income: Codable {
    var category: Category
    var amount: Double
    var date: Date
    
    init(with category: Category, amount: Double, date: Date){
        self.category = category
        self.amount = amount
        self.date = date
    }
}
