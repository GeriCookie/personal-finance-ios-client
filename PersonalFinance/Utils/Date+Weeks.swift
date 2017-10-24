//
//  Date+Weeks.swift
//  PersonalFinance
//
//  Created by Cookie on 23.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

enum DayOfWeek: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 0
}

extension Date {
    func getDate(forDayOfWeek dayOfWeek: DayOfWeek) -> Date {
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 2
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        components.weekday = dayOfWeek.rawValue + 1
        return calendar.date(from: components)!
    }
    
    var startOfWeek:Date {
        return getDate(forDayOfWeek: .monday)
    }
    
    var endOfWeek: Date {
        return getDate(forDayOfWeek: .sunday)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return calendar.date(byAdding: components, to: self.startOfMonth)!
    }
    
    var nextDay: Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.day = 1
        return calendar.date(byAdding: components, to: self)!
    }
    
    var prevDay: Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.day = -1
        return calendar.date(byAdding: components, to: self)!
    }
    
    static var now: Date {
        get {
            return Date()
        }
    }
}
