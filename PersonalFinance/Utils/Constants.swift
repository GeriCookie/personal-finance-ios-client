//
//  Constants.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

//URL constants
let BASE_URL = "http://localhost:8000"
//let BASE_URL = "http://192.168.1.8:8000"
let REGISTER_URL = "\(BASE_URL)/accounts/registration/mobile/"
let LOGIN_URL = "\(BASE_URL)/accounts/rest-auth/login/"
let CATEGORY_URL = "\(BASE_URL)/api/categories/"
let INCOMES_URL = "\(BASE_URL)/api/incomes/"
let EXPENSES_URL = "\(BASE_URL)/api/expenses/"

//User defaults
let TOKEN_KEY = "token"
let USERNAME_KEY = "username"


let INCOME_CELL_IDENTIFIER = "IncomeCell"
