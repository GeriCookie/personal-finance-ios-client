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
    
    func getExpensesByDate(from startDate: Date, to endDate: Date) {
        let url = "\(EXPENSES_BY_DATE_URL)/?date_0=\(format(date: startDate))&date_1=\(format(date: endDate))"
        print(url)
        httpRequester?.get(from: url)
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

protocol ExpenseServiceDelegate {
    func didPostExpenseSuccess()
    func didGetExpensesByDateSuccess(with expensesByDate: [ExpenseByDate])
    func didGetExpensesFailed(with error: BackendError)
}

extension ExpenseServiceDelegate {
    func didPostExpenseSuccess() {}
    func didGetExpensesByDateSuccess(with expensesByDate: [ExpenseByDate]) {}
    func didGetExpensesFailed(with error: BackendError) {}
}

extension ExpenseService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        if let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            print(response)
        }
        guard let result = try? decoder.decode([ExpenseByDate].self, from: data) else {
            delegate?.didGetExpensesFailed(with: BackendError.generalError(reason: "Cannot decode"))
            return
        }
        
        delegate?.didGetExpensesByDateSuccess(with: result)
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

