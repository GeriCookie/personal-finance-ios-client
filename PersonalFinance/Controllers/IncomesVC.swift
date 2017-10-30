//
//  IncomesVC.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Charts

class IncomesVC: UIViewController {
    
    var service: IncomeService?
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var currentDate = Date.now
    var currentDateIntervalType: DateIntervalType = .month
    var incomes = [IncomeByDate]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = IncomeService()
        service?.delegate = self
        service?.getIncomesByDate(from: currentDate.startOfMonth, to: currentDate.endOfMonth)
    }

    override func viewDidAppear(_ animated: Bool) {
        service?.getIncomesByDate(from: currentDate.startOfMonth, to: currentDate.endOfMonth)
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
            service?.getIncomesByDate(from: currentDate, to: currentDate)
        case .week:
            service?.getIncomesByDate(from: (currentDate.startOfWeek), to: (currentDate.endOfWeek))
        case .month:
            service?.getIncomesByDate(from: (currentDate.startOfMonth), to: (currentDate.endOfMonth))
        case .year:
            service?.getIncomesByDate(from: (currentDate.startOfYear), to: (currentDate.endOfYear))
        }
        updateUI()
    }
    
    
    @IBAction func onPrevDateClicked(_ sender: Any) {
        updateDate(byAdding: -1)
    }
    
    @IBAction func onNextDateClicked(_ sender: Any) {
        updateDate(byAdding: +1)
    }
    
    @IBAction func onDateIntervalTypeChanged(_ sender: UISegmentedControl) {
        currentDateIntervalType = DateIntervalType(rawValue: sender.selectedSegmentIndex)!
        updateDate(byAdding: 0)
    }
    
}

extension IncomesVC: ChartViewDelegate {
    func updatePieChart() {
        let entries: [PieChartDataEntry] = incomes.map {income in
            let entry = PieChartDataEntry(value: income.amountPerCategory, label: income.categoryName)
            return entry
        }
        
        let colors: [UIColor] = incomes.map {income in
            let color = UIColor.returnUIColor(components: income.categoryColor)
            
            return color
        }
        //        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
        //        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
        //        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        pieChart.chartDescription?.textColor = UIColor.white
        pieChart.chartDescription?.font = .systemFont(ofSize: 15, weight: .bold)
        let dataSet = PieChartDataSet(values: entries, label: "Expenses Types")
        let data = PieChartData(dataSet: dataSet)
        
        pieChart.data = data
        pieChart.chartDescription?.text = "Expenses"
        dataSet.colors = colors
        dataSet.valueFont = .systemFont(ofSize: 15, weight: .bold)
        
        pieChart.notifyDataSetChanged()
    }
}



extension IncomesVC: IncomeServiceDelegate {
    func didGetIncomesByDateSuccess(with incomes: [IncomeByDate]) {
        self.incomes = incomes
        updateUI()
    }
}
