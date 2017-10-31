//
//  BalanceService.swift
//  PersonalFinance
//
//  Created by Cookie on 31.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class BalanceService {
    var httpRequester: HttpRequester?
    var delegate: BalanceServiceDelegate?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
    }
    
    func getBalance() {
        httpRequester?.get(from: BALANCE_URL)
    }
}

extension BalanceService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        let balance = try? decoder.decode([Balance].self, from: data)
        
        if let balance = balance {
            delegate?.didGetBalanceSuccess(balance: balance[0])
            return
        }
        
        delegate?.didGetBalanceSuccess(balance: nil)
    }
}

protocol BalanceServiceDelegate {
    func didGetBalanceSuccess(balance: Balance?)
}

extension BalanceServiceDelegate {
    func didGetBalanceSuccess(balance: Balance?) { }
}
