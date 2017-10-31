//
//  Balance.swift
//  PersonalFinance
//
//  Created by Cookie on 31.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class Balance: Codable {
    var recommendedExpensesPerDay: String?
    
    var totalIncome: String?
    var totalExpense: String?
    var totalSavings: String?
    var totalAmount: String?
    
    var remainingBudget: String?
    var targetSavingsBudgetEnd: String?
    
    var averageExpensesPerDay: String?
    var endDateAvailableFunds: String?
    
    var incomes: [Income]?
    var expenses: [Expense]?
    var savingGoals: [SavingsGoal]?
    var budget: [Budget]
    
    enum CodingKeys: String, CodingKey {
        case budget
        case expenses
        case incomes
        case endDateAvailableFunds = "end_date_available_funds"
        case averageExpensesPerDay = "average_expenses_per_day"
        case recommendedExpensesPerDay = "recommended_expenses_per_day"
        case remainingBudget = "remaining_budget"
        case savingGoals = "savings_goals"
        case targetSavingsBudgetEnd = "target_savings_budget_end"
        case totalAmount = "total_amount"
        case totalExpense = "total_expense"
        case totalIncome = "total_income"
        case totalSavings = "total_savings"
    }
}
