//
//  BudgetAndSavingsVC.swift
//  PersonalFinance
//
//  Created by Cookie on 30.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class BudgetAndSavingsVC: UIViewController {
    var budget: Budget?
    var savingsGoal: SavingsGoal?
    
    @IBOutlet weak var budgetEndDateLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var budgetCompletedLabel: UILabel!
    @IBOutlet weak var budgetCompletedSegment: UISwitch!
    
    @IBOutlet weak var savingsGoalEndDateLabel: UILabel!
    @IBOutlet weak var savingsGoalAmountLabel: UILabel!
    @IBOutlet weak var savingsGoalCompletedLabel: UILabel!
    @IBOutlet weak var savingsGoalCompletedSegment: UISwitch!
    
    @IBAction func prepareForUnwindBS(segue: UIStoryboardSegue) {}
    
    var budgetService: BudgetService?
    var savingsGoalService: SavingsGoalService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetService = BudgetService ()
        budgetService?.delegate = self
        savingsGoalService = SavingsGoalService()
        savingsGoalService?.delegate = self
        self.title = "Budget & Savings"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        budgetService?.getBudget()
        savingsGoalService?.getSavingsGoal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBudgetCompletedChanged(_ sender: UISwitch) {
        budgetCompletedLabel.text = sender.isOn
            ? "Completed"
            : "Not completed"
        
    }
    
    @IBAction func onSavingsGoalCompletedChanged(_ sender: UISwitch) {
        savingsGoalCompletedLabel.text = sender.isOn
            ? "Completed"
            : "Not completed"
    }
    
    func updateUI() {
        if let budget = budget {
            DispatchQueue.main.async {
                self.budgetEndDateLabel.text = budget.endDate
                self.budgetAmountLabel.text = budget.amount
                self.budgetCompletedSegment.isOn = budget.completed
               
            }
        }
            
        if let savingsGoal = savingsGoal {
            DispatchQueue.main.async {
                self.savingsGoalEndDateLabel.text = savingsGoal.endDate
                self.savingsGoalAmountLabel.text = savingsGoal.amount
                self.savingsGoalCompletedSegment.isOn = savingsGoal.completed!
            }
        }
    }
}

extension BudgetAndSavingsVC: BudgetServiceDelegate {
    func didGetBudget(_ budget: Budget?) {
        self.budget = budget
        updateUI()
    }
}

extension BudgetAndSavingsVC: SavingsGoalServiceDelegate {
    func didGetSavingsGoal(_ savingsGoal: SavingsGoal?) {
        self.savingsGoal = savingsGoal
        updateUI()
    }
}
