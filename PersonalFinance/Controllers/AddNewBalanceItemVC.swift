//
//  AddNewBalanceItemVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class AddNewBalanceItemVC: UIViewController {
    var cacheService: CacheService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cacheService = CacheService()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add expense" || segue.identifier == "add income" {
            let balanceType: IncomeOrExpense = (segue.identifier == "add expense")
                ? .expense
                : .income
            
            cacheService?.setBalanceType(type: balanceType)
        }
        if segue.identifier == "add savings goal" || segue.identifier == "add budget" {
            let balanceType: BudgetOrSavings = (segue.identifier == "add budget")
                ? .budget
                : .savings
            
            cacheService?.setBalanceType(type: balanceType)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
