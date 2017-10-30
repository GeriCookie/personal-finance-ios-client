//
//  AddBudgetOrSavingsGoal.swift
//  PersonalFinance
//
//  Created by Cookie on 30.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum BudgetOrSavings: String {
    case budget = "Budget"
    case savings = "Savings"
}

class AddBudgetOrSavingsGoal: UIViewController {
    var type: BudgetOrSavings?
    
    var endDate: String?
    var budgetService: BudgetService?
    var savingsGoalService: SavingsGoalService?
    var cacheService: CacheService?
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetService = BudgetService()
        budgetService?.delegate = self
        savingsGoalService = SavingsGoalService()
        savingsGoalService?.delegate = self
        cacheService = CacheService()
        type = cacheService?.getBalanceType()
        if type == .budget {
            self.title = "Add Budget"
        } else if type == .savings {
            self.title = "Add Savings goal"
        } else {
            self.title = "Add"
        }
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        endDate = strDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAddClicked(_ sender: Any) {
        //Check if amount is double
        guard let amountValue = amount.text, amount.text != "" else {
            return
        }
        
        if endDate == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatter.string(from: datePicker.date)
            endDate = strDate
        }
        
        if let date = endDate {
            if type == .budget {
                budgetService?.addBudget(withAmount: amountValue, andEndDate: date)
            } else if type == .savings {
                savingsGoalService?.addSavingsGoal(withAmount: amountValue, andEndDate: date)
            }
        }
    }
}

extension AddBudgetOrSavingsGoal: SavingsGoalServiceDelegate {
    func didAddSavingsGoalSucces() {
        let msg = "Savings goal added"
        showSuccess(with: msg)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: UNWIND_TO_BUDGET_AND_SAVINGS, sender: nil)
        }
    }
}

extension AddBudgetOrSavingsGoal: BudgetServiceDelegate {
    func didAddBudgetSuccess() {
        let msg = "Budget added"
        showSuccess(with: msg)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: UNWIND_TO_BUDGET_AND_SAVINGS, sender: nil)
        }
    }
}
