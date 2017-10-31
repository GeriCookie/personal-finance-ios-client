//
//  SavingsGoalService.swift
//  PersonalFinance
//
//  Created by Cookie on 30.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class SavingsGoalService {
    let httpRequester: HttpRequester
    var delegate: SavingsGoalServiceDelegate?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester.delegate = self
    }
    
    func addSavingsGoal(withAmount amount: String, andEndDate endDate: String) {
        let budget = Budget(withAmount: amount, endDate: endDate, andCompleted: false)
        
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(budget)
        } catch {
            print(error)
        }
        
        httpRequester.post(to: SAVINGS_GOAL_URL, with: body)
    }
    
    func getSavingsGoal() {
        httpRequester.get(from: SAVINGS_GOAL_URL)
    }
}


extension SavingsGoalService: HttpRequesterDelegate {
    func didPostSuccess(with data: Data) {
        delegate?.didAddSavingsGoalSucces()
    }
    
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        let savingsGoals = try? decoder.decode([SavingsGoal].self, from: data)
        if let savingsGoals = savingsGoals {
            let savingsGoal = savingsGoals.count > 0
                ? savingsGoals[savingsGoals.count - 1]
                : nil
            
            delegate?.didGetSavingsGoal(savingsGoal)
            return
        }
        
        delegate?.didGetSavingsGoal(nil)
    }
}

protocol SavingsGoalServiceDelegate {
    func didAddSavingsGoalSucces()
    func didGetSavingsGoal(_ savingsGoal: SavingsGoal?)
}

extension SavingsGoalServiceDelegate {
    func didAddSavingsGoalSucces() { }
    func didGetSavingsGoal(_ savingsGoal: SavingsGoal?) { }
}

