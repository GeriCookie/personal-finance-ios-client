//
//  AddIncomeVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum IncomeOrExpense: String {
    case income = "Income"
    case expense = "Expense"
}

class AddIncomeOrExpenseVC: UIViewController {
    
    var type: IncomeOrExpense?
    
    var category: Category?
    var date: String?
    var incomeService: IncomeService?
    var expenseService: ExpenseService?
    var cacheService: CacheService?
    
    @IBOutlet weak var categoryButton: RoundedButton!
    @IBOutlet weak var categoryName: UILabel!

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var addButton: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeService = IncomeService()
        expenseService = ExpenseService()
        cacheService = CacheService()
        
        incomeService?.delegate = self
        expenseService?.delegate = self
        type = cacheService?.getBalanceType()
        if type == .income {
            self.title = "Add Income"
            self.addButton.setTitle("Add Income", for: .normal)
        } else if type == .expense {
            self.title = "Add Expense"
            self.addButton.setTitle("Add Expense", for: .normal)
        } else {
            self.title = "Add"
        }
        setupView()
    }
    
    @IBAction func onAddClicked(_ sender: UIButton) {
        //Check if amount is double
        guard let amount = amountField.text, amountField.text != "" else {
            return
        }
        
        print("Date: \(date)")
        if date == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatter.string(from: datePicker.date)
            date = strDate
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
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
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}

extension AddIncomeOrExpenseVC: CategoryVCDelegate {
    func didSelectCategory(_ category: Category) {
        categoryName.text = category.name
        colorView.backgroundColor = UIColor.returnUIColor(components: category.color)
        self.category = category
        self.categoryButton.setTitle("Change category", for: .normal)
    }
}

extension AddIncomeOrExpenseVC: IncomeServiceDelegate {
    func didPostIncomeSuccess() {
        let msg = "Income added"
        showSuccess(with: msg)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: UNWIND_TO_INCOMES, sender: nil)
        }
        
    }
    
    func didGetIncomesSuccess(with incomes: [Income]) {
    }
}

extension AddIncomeOrExpenseVC: ExpenseServiceDelegate {
    func didPostExpenseSuccess() {
        let msg = "Expense added"
        
        showSuccess(with: msg)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: UNWIND_TO_EXPENSES, sender: nil)
        }
    }
}
