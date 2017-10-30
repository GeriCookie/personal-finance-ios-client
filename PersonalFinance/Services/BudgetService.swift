//
//  BudgetService.swift
//  PersonalFinance
//
//  Created by Cookie on 30.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class BudgetService {
    let httpRequester: HttpRequester
    var delegate: BudgetServiceDelegate?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester.delegate = self
    }
    
    func addBudget(withAmount amount: String, andEndDate endDate: String) {
        let budget = Budget(withAmount: amount, endDate: endDate, andCompleted: false)
        
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(budget)
        } catch {
            print(error)
        }

        httpRequester.post(to: BUDGET_URL, with: body)
    }
}


extension BudgetService: HttpRequesterDelegate {
    func didPostSuccess(with data: Data) {
        delegate?.didAddBudgetSuccess()
    }
}

protocol BudgetServiceDelegate {
    func didAddBudgetSuccess()
}

extension BudgetServiceDelegate {
    func didAddBudgetSuccess() { }
}
