//
//  IncomeService.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class IncomeService {
    var delegate: IncomeServiceDelegate?
    var httpRequester: HttpRequester?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
    }
    
    func addIncome(with category: Category, amount: String, date: String) {
        let income = Income(with: category, amount: amount, date: date)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(income)
        } catch {
            print(error)
        }
        
        httpRequester?.post(to: INCOMES_URL, with: body)
    }
    
    func getIncomes() {
        httpRequester?.get(from: INCOMES_URL)
    }
    
    func getIncomesByDate(from startDate: Date, to endDate: Date) {
        let url = "\(INCOMES_BY_DATE_URL)/?date_0=\(format(date: startDate))&date_1=\(format(date: endDate))"
        print(url)
        httpRequester?.get(from: url)
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

protocol IncomeServiceDelegate {
    func didPostIncomeSuccess()
    func didGetIncomesByDateSuccess(with incomes: [IncomeByDate])
    func didGetIncomesFailed(with error: BackendError)
}

extension IncomeServiceDelegate {
    func didPostIncomeSuccess() {}
    func didGetIncomesByDateSuccess(with incomes: [IncomeByDate]) {}
    func didGetIncomesFailed(with error: BackendError) {}
}

extension IncomeService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        if let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            print(response)
        }
        guard let result = try? decoder.decode([IncomeByDate].self, from: data) else {
            delegate?.didGetIncomesFailed(with: BackendError.generalError(reason: "Cannot decode"))
            return
        }
        
        delegate?.didGetIncomesByDateSuccess(with: result)
    }
    
    func didGetFailed(with error: BackendError) {
        
    }
    
    func didPostSuccess(with data: Data) {
        delegate?.didPostIncomeSuccess()
    }
    
    func didPostFailed(with error: BackendError) {
        
    }
    
    func didPostFailed(with error: Data) {
        
    }
    
    
}
