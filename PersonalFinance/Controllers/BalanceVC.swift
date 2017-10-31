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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceService = BalanceService()
        balanceService?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        balanceService?.getBalance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        if let balance = balance {
            print(balance)
        }
    }
}

extension BalanceVC: BalanceServiceDelegate {
    func didGetBalanceSuccess(balance: Balance?) {
        self.balance = balance
        updateUI()
    }
}
