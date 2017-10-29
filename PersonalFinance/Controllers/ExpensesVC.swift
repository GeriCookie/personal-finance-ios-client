//
//  ExpensesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
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

class ExpensesVC: UIViewController {
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var service: ExpenseService?
    
    var expenses = [ExpenseByDate]()
    var currentDate = Date.now
    var currentDateIntervalType: DateIntervalType = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDate = Date()
        updateDate(byAdding: 0)
        
        service = ExpenseService()
        service?.delegate = self
        
        service?.getExpensesByDate(from: currentDate, to: currentDate)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        service?.getExpensesByDate(from: currentDate, to: currentDate)
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
//        guard let date = currentDate else {
//            return ""
//        }
        
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
//        guard let date = currentDate else {
//            return ""
//        }
        
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
//        guard let date = currentDate else {
//            return
//        }
        
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
        
        // TODO:
        switch currentDateIntervalType {
        case .day:
            service?.getExpensesByDate(from: currentDate, to: currentDate)
        case .week:
            service?.getExpensesByDate(from: (currentDate.startOfWeek), to: (currentDate.endOfWeek))
        case .month:
            service?.getExpensesByDate(from: (currentDate.startOfMonth), to: (currentDate.endOfMonth))
        case .year:
            service?.getExpensesByDate(from: (currentDate.startOfYear), to: (currentDate.endOfYear))
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
}

extension ExpensesVC: ChartViewDelegate {
    func updatePieChart() {
        let entries: [PieChartDataEntry] = expenses.map {expense in
            let entry = PieChartDataEntry(value: expense.amountPerCategory, label: expense.categoryName)
            
            return entry
        }
        
        let colors: [UIColor] = expenses.map {expense in
            let color = UIColor.returnUIColor(components: expense.categoryColor)
            
            return color
        }
//        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
//        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
//        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        let dataSet = PieChartDataSet(values: entries, label: "Expenses Types")
        let data = PieChartData(dataSet: dataSet)
        
        pieChart.data = data
        pieChart.chartDescription?.text = "Expenses"
        dataSet.colors = colors
        
        pieChart.notifyDataSetChanged()
    }
}

extension ExpensesVC: ExpenseServiceDelegate {
    func didGetExpensesByDateSuccess(with expensesByDate: [ExpenseByDate]) {
        print(expensesByDate)
        self.expenses = expensesByDate
        updateUI()
    }
}

