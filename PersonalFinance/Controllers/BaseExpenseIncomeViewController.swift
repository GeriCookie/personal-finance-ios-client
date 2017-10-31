//
//  BaseExpenseIncomeViewController.swift
//  PersonalFinance
//
//  Created by Cookie on 31.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Charts

enum DateIntervalType: Int {
    case day = 0
    case week = 1
    case month = 2
    case year = 3
}

class BaseExpenseIncomeViewController: UIViewController {
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var type: IncomeOrExpense?
    var expenseService: ExpenseService?
    var incomeService: IncomeService?
    
    var cacheService: CacheService?
    
    var expenses = [ExpenseByDate]()
    var incomes = [IncomeByDate]()
    
    var currentDate = Date.now
    var currentDateIntervalType: DateIntervalType = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDate = Date()
        updateDate(byAdding: 0)
        
        expenseService = ExpenseService()
        expenseService?.delegate = self
        
        incomeService = IncomeService()
        incomeService?.delegate = self
        
        cacheService = CacheService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if type == .expense {
            expenseService?.getExpensesByDate(from: currentDate, to: currentDate)
        } else {
            incomeService?.getIncomesByDate(from: currentDate, to: currentDate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            self.updatePieChart()
            self.currentDateLabel.text = text
        }
    }
    
    func getDayText() -> String {
        //        guard let date = currentDate else {
        //            return ""
        //        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var text = dateFormatter.string(from: currentDate)
        
        if currentDate.sameDay(as: Date.now) {
            text = "Today"
        } else if currentDate.sameDay(as: Date.now.prevDay) {
            text = "Yesterday"
        }
        
        return text
    }
    
    func getWeekText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        print(currentDate.startOfWeek)
        print(dateFormatter.string(from: (currentDate.startOfWeek)))
        
        var text = "\(dateFormatter.string(from: currentDate.startOfWeek)) - \(dateFormatter.string(from: currentDate.endOfWeek))"
        
        if currentDate.sameWeek(as: Date.now) {
            text = "This week"
        }
        
        return text
    }
    
    func getMonthText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        var text = dateFormatter.string(from: currentDate.startOfMonth)
        
        if currentDate.sameMonth(as: Date.now) {
            text = "This month"
        }
        
        return text
    }
    
    func getYearText() -> String {
        //        guard let date = currentDate else {
        //            return ""
        //        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        
        var text = dateFormatter.string(from: currentDate.startOfYear)
        print(Date.now.startOfYear)
        print(Date.now)
        if Date.now.startOfYear <= currentDate {
            text = "This year"
        }
        
        return text
    }
    
    func updateDate(byAdding value: Int) {
        var components = DateComponents()
        switch(currentDateIntervalType) {
        case .day:
            components.day = value
        case .week:
            components.weekOfMonth = value
        case .month:
            components.month = value
        case .year:
            components.year = value
        }
        
        currentDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: currentDate)!
        load()
    }
    
    func load() {
        switch currentDateIntervalType {
        case .day:
            if type == .expense {
                expenseService?.getExpensesByDate(from: currentDate, to: currentDate)
            } else {
                incomeService?.getIncomesByDate(from: currentDate, to: currentDate)
            }
        case .week:
            if type == .expense {
                expenseService?.getExpensesByDate(from: (currentDate.startOfWeek), to: (currentDate.endOfWeek))
            } else {
                incomeService?.getIncomesByDate(from: (currentDate.startOfWeek), to: (currentDate.endOfWeek))
            }
        case .month:
            if type == .expense {
                expenseService?.getExpensesByDate(from: (currentDate.startOfMonth), to: (currentDate.endOfMonth))
            } else {
                incomeService?.getIncomesByDate(from: (currentDate.startOfMonth), to: (currentDate.endOfMonth))
            }
        case .year:
            
            if type == .expense {
                expenseService?.getExpensesByDate(from: (currentDate.startOfYear), to: (currentDate.endOfYear))
            } else {
                incomeService?.getIncomesByDate(from: (currentDate.startOfYear), to: (currentDate.endOfYear))
            }
        }
        updateUI()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cacheService?.setBalanceType(type: type!)
    }
}

extension BaseExpenseIncomeViewController: ChartViewDelegate {
    func updatePieChart() {
        var entries: [PieChartDataEntry]
        if type == .expense {
            entries = expenses.map {expense in
                let entry = PieChartDataEntry(value: expense.amountPerCategory, label: expense.categoryName)
                return entry
            }
        } else {
            entries = incomes.map {income in
                let entry = PieChartDataEntry(value: income.amountPerCategory, label: income.categoryName)
                return entry
            }
        }
        
        var colors: [UIColor]
        if type == .expense {
            colors = expenses.map {expense in
                let color = UIColor.returnUIColor(components: expense.categoryColor)
                
                return color
            }
        } else {
            colors = incomes.map {income in
                let color = UIColor.returnUIColor(components: income.categoryColor)
                
                return color
            }
        }
        //        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
        //        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
        //        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        pieChart.chartDescription?.textColor = UIColor.white
        pieChart.chartDescription?.font = .systemFont(ofSize: 15, weight: .bold)
        let labelMessage = type == .expense
            ? "Expenses Types"
            : "Incomes Types"
        let dataSet = PieChartDataSet(values: entries, label: labelMessage)
        let data = PieChartData(dataSet: dataSet)
        
        pieChart.data = data
        pieChart.chartDescription?.text = "Expenses"
        dataSet.colors = colors
        dataSet.valueFont = .systemFont(ofSize: 15, weight: .bold)
        
        pieChart.notifyDataSetChanged()
    }
}

extension BaseExpenseIncomeViewController: ExpenseServiceDelegate {
    func didGetExpensesByDateSuccess(with expensesByDate: [ExpenseByDate]) {
        print(expensesByDate)
        self.expenses = expensesByDate
        updateUI()
    }
}

extension BaseExpenseIncomeViewController: IncomeServiceDelegate {
    func didGetIncomesByDateSuccess(with incomes: [IncomeByDate]) {
        print(incomes)
        self.incomes = incomes
        updateUI()
    }
}


