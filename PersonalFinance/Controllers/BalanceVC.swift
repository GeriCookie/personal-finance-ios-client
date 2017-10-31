//
//  BalanceVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class BalanceVC: UIViewController {
    var balance: Balance?
    var balanceService: BalanceService?
    var cacheService: CacheService?
    
    @IBOutlet weak var recommendedExpensesByDayLabel: UILabel!
    
    @IBOutlet weak var remainingBudgetLabel: UILabel!
    
    @IBOutlet weak var savingsByCurrentBudgetLabel: UILabel!
    
    @IBOutlet weak var averageExpesesPerDayLabel: UILabel!
    @IBOutlet weak var fundsEndLabel: UILabel!
    
    @IBOutlet weak var allIncomesLabel: UILabel!
    
    @IBOutlet weak var allExpensesLabel: UILabel!
    @IBOutlet weak var allSavingsLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceService = BalanceService()
        balanceService?.delegate = self
        
        cacheService = CacheService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if cacheService?.authToken != "" {
            balanceService?.getBalance()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        if let balance = balance {
            DispatchQueue.main.async {
                self.recommendedExpensesByDayLabel.text = balance.recommendedExpensesPerDay == ""
                    ? "No info"
                    : balance.recommendedExpensesPerDay
                
                self.remainingBudgetLabel.text = balance.remainingBudget == ""
                    ? "No Budget"
                    : balance.remainingBudget
                
                self.savingsByCurrentBudgetLabel.text = balance.targetSavingsBudgetEnd == ""
                    ? "No Budget"
                    : balance.targetSavingsBudgetEnd
                
                self.averageExpesesPerDayLabel.text = balance.averageExpensesPerDay
                self.fundsEndLabel.text = balance.endDateAvailableFunds
                self.allIncomesLabel.text = balance.totalIncome
                self.allExpensesLabel.text = balance.totalExpense
                self.allSavingsLabel.text = balance.totalSavings
                self.totalAmountLabel.text = balance.totalAmount
            }
        }
    }
}

extension BalanceVC: BalanceServiceDelegate {
    func didGetBalanceSuccess(balance: Balance?) {
        self.balance = balance
        updateUI()
    }
}
