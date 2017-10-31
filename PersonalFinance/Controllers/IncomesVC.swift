//
//  IncomesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Charts

class IncomesVC: BaseExpenseIncomeViewController {
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        type = .income
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = .income
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
