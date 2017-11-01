//
//  Constants.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

//URL constants
//let BASE_URL = "http://localhost:8000"
let BASE_URL = "http://cookie-rocks.com"
let REGISTER_URL = "\(BASE_URL)/accounts/registration/mobile/"
let LOGIN_URL = "\(BASE_URL)/accounts/rest-auth/login/"
let CATEGORY_URL = "\(BASE_URL)/api/categories/"
let INCOMES_URL = "\(BASE_URL)/api/incomes/"
let EXPENSES_URL = "\(BASE_URL)/api/expenses/"
let EXPENSES_BY_DATE_URL = "\(BASE_URL)/api/expenses-by-date"
let INCOMES_BY_DATE_URL = "\(BASE_URL)/api/incomes-by-date"

let BUDGET_URL = "\(BASE_URL)/api/budget/"
let SAVINGS_GOAL_URL = "\(BASE_URL)/api/savings-goals/"

let BALANCE_URL = "\(BASE_URL)/api/balance/"

//User defaults
let TOKEN_KEY = "token"
let USERNAME_KEY = "username"
let BALANCE_TYPE_KEY = "balance type"

let INCOME_CELL_IDENTIFIER = "IncomeCell"

let UNWIND_TO_INCOMES = "toIncomes"
let UNWIND_TO_BUDGET_AND_SAVINGS = "toBudgetAndSavings"
let UNWIND_TO_EXPENSES = "toExpenses"

let CATEGORY_COLORS = [#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1), #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1),
                       #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1), #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1), #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1),
                       #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1), #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1), #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.2340766059, green: 0.6412734522, blue: 0.764492929, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                       #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
                       #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.457546658, green: 0.1678847803, blue: 0.764492929, alpha: 1)]
