//
//  Category.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class Category : Codable {
    var name: String
    var color: String
    
    init(with name: String, and color: String) {
        self.name = name
        self.color = color
    }
}
