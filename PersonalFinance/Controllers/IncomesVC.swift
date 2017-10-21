//
//  IncomesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class IncomesVC: UIViewController {
    
    var incomesService: IncomeService?
//    var budgetService: BudgetService?
//    var savingsService: SavingsService?
    
    @IBOutlet weak var tableView: UITableView!
    var incomes = [Income]()
    //var budgets: [Budget]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        incomesService = IncomeService()
        incomesService?.delegate = self
        incomesService?.getIncomes()
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension IncomesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: INCOME_CELL_IDENTIFIER, for: indexPath) as? IncomeCell {
            cell.date.text = incomes[indexPath.row].date
            cell.categoryName.text = incomes[indexPath.row].category.name
            cell.amount.text = "\(incomes[indexPath.row].amount)"
            return cell
        }
        return UITableViewCell()
    }
}

extension IncomesVC: IncomeServiceDelegate {
    func didGetIncomesSuccess(with incomes: [Income]) {
        self.incomes = incomes
        updateUI()
    }
}
