//
//  ExpensesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum DateIntervalType: Int {
    case day = 0
    case week = 1
    case month = 2
    case year = 3
}

class ExpensesVC: UIViewController {
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var service: ExpenseService?
    
    var expenses = [Expense]()
    var currentDate: Date?
    var currentDateIntervalType: DateIntervalType = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tableView.register(IncomeCell.self, forCellReuseIdentifier: INCOME_CELL_IDENTIFIER)
        tableView.dataSource = self
        
        currentDate = Date()
        updateDate(byAdding: 0)
        
        service = ExpenseService()
        service?.delegate = self
        
        service?.getExpenses()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        var text = ""
        switch(self.currentDateIntervalType) {
        case .day:
            text = self.getDayText()
        case .week:
            text = self.getWeekText()
        case .month:
            text =  self.getMonthText()
        case .year:
            text =  self.getYearText()
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.currentDateLabel.text = text
        }
    }
    
    func getDayText() -> String {
        guard let date = currentDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var text = dateFormatter.string(from: currentDate!)
        
        if date == Date.now {
            text = "Today"
        } else if date == Date.now.prevDay {
            text = "Yesterday"
        }
        
        return text
    }
    
    func getWeekText() -> String {
        guard let date = currentDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        var text = "\(dateFormatter.string(from: date.startOfWeek)) - \(dateFormatter.string(from: date.endOfWeek))"
        
        if Date.now.startOfWeek <= date {
            text = "This week"
        }
        
        return text
    }
    
    func getMonthText() -> String {
        guard let date = currentDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        var text = dateFormatter.string(from: date.startOfMonth)
        
        if Date.now.startOfMonth <= date {
            text = "This month"
        }
        
        return text
    }
    
    func getYearText() -> String {
        guard let date = currentDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY"
        
        var text = dateFormatter.string(from: date.startOfMonth)
        
        if Date.now.startOfMonth <= date {
            text = "This year"
        }
        
        return text
    }
    
    func updateDate(byAdding value: Int) {
        guard let date = currentDate else {
            return
        }
        
        var components = DateComponents()
        switch(currentDateIntervalType) {
        case .day:
            currentDate = date.nextDay
        case .week:
            components.weekOfMonth = value
        case .month:
            components.month = value
        case .year:
            components.year = value
        }
        
        currentDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: date)
        load()
    }
    
    func load() {
        updateUI()
        // TODO:
        //        switch currentDateIntervalType {
        //        case .day:
        //            service?.getExpenses(for: currentDate)
        //        case .week:
        //            service?.getExpenses(from: currentDate?.startOfMonth, to: currentDate?.endOfWeek)
        //        }
        //        service?.getExpenses()
    }
    
    @IBAction func onPrevDateClick(_ sender: Any) {
        updateDate(byAdding: -1)
    }
    
    @IBAction func onNextDateClick(_ sender: Any) {
        updateDate(byAdding: +1)
    }
    
    @IBAction func onDateIntervalTypeChanged(_ sender: UISegmentedControl) {
        currentDateIntervalType = DateIntervalType(rawValue: sender.selectedSegmentIndex)!
        updateDate(byAdding: 0)
    }
}

extension ExpensesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: INCOME_CELL_IDENTIFIER, for: indexPath)
        if let cell = cell as? IncomeCell {
            cell.date.text = expenses[indexPath.row].date
            cell.categoryName.text = expenses[indexPath.row].category.name
            cell.amount.text = "\(expenses[indexPath.row].amount)"
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ExpensesVC: ExpenseServiceDelegate {
    func didGetExpensesSuccess(with expenses: [Expense]) {
        self.expenses = expenses
        updateUI()
    }
}
