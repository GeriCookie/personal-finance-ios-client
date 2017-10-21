//
//  AddIncomeVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum IncomeOrExpense {
    case income
    case expense
}

class AddIncomeOrExpenseVC: UIViewController {
    
    var type: IncomeOrExpense?
    
    var category: Category?
    var date: String?
    var incomeService: IncomeService?
    var expenseService: ExpenseService?
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryColor: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeService = IncomeService()
        expenseService = ExpenseService()
        
        incomeService?.delegate = self
        expenseService?.delegate = self
    }
    
    @IBAction func onAddClicked(_ sender: UIButton) {
        //Check if amount is double
        guard let amount = amountField.text, amountField.text != "" else {
            return
        }
        
        
        if let date = date, let category = category {
            if type == .expense {
                expenseService?.addExpense(with: category, amount: amount, date: date)
            } else {
                incomeService?.addIncome(with: category, amount: amount, date: date)
            }
        }
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var strDate = dateFormatter.string(from: datePicker.date)
        date = strDate
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "choose category") {
            let modal = segue.destination
            guard let categoryVC = modal as? CategoryVC else {
                return
            }
            
            categoryVC.delegate = self
        }
    }
}

extension AddIncomeOrExpenseVC: CategoryVCDelegate {
    func didSelectCategory(_ category: Category) {
        categoryName.text = category.name
        categoryColor.text = category.color
        self.category = category
    }
}

extension AddIncomeOrExpenseVC: IncomeServiceDelegate {
    func didPostIncomeSuccess() {
        let msg = "Income added"
        showSuccess(with: msg)
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "IncomesSavingsBudgetVC")
            self.dismiss(animated: true, completion: {
                self.show(nextVC, sender: nil)
            })
        }
    }
    
    func didGetIncomesSuccess(with incomes: [Income]) {
    }
}

extension AddIncomeOrExpenseVC: ExpenseServiceDelegate {
    func didPostExpenseSuccess() {
        let msg = "Expense added"
        
        showSuccess(with: msg)
        dismiss(animated: true, completion: nil)
    }
}
