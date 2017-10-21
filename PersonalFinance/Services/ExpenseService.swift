//
//  ExpenseService.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

//
//  ExpenseService.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class ExpenseService {
    var delegate: ExpenseServiceDelegate?
    var httpRequester: HttpRequester?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
    }
    
    func addExpense(with category: Category, amount: String, date: String) {
        let expense = Expense(with: category, amount: amount, date: date)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(expense)
        } catch {
            print(error)
        }
        
        httpRequester?.post(to: EXPENSES_URL, with: body)
    }
    
    func getExpenses() {
        httpRequester?.get(from: EXPENSES_URL)
    }
}

protocol ExpenseServiceDelegate {
    func didPostExpenseSuccess()
    func didGetExpensesSuccess(with expenses: [Expense])
    func didGetExpensesFailed(with error: BackendError)
}

extension ExpenseServiceDelegate {
    func didPostExpenseSuccess() {}
    func didGetExpensesSuccess(with expenses: [Expense]) {}
    func didGetExpensesFailed(with error: BackendError) {}
}

extension ExpenseService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode([Expense].self, from: data) else {
            delegate?.didGetExpensesFailed(with: BackendError.generalError(reason: "Cannot decode"))
            return
        }
        
        delegate?.didGetExpensesSuccess(with: result)
    }
    
    func didGetFailed(with error: BackendError) {
        
    }
    
    func didPostSuccess(with data: Data) {
        delegate?.didPostExpenseSuccess()
    }
    
    func didPostFailed(with error: BackendError) {
        
    }
    
    func didPostFailed(with error: Data) {
        
    }
    
    
}

