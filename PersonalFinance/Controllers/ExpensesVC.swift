//
//  ExpensesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Charts

class ExpensesVC: BaseExpenseIncomeViewController {
    @IBAction func prepareForUnwindExpences(segue: UIStoryboardSegue) {}

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        type = .expense
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = .expense
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

