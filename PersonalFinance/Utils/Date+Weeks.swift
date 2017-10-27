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

    func sameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .day) == .orderedSame
    }

    func sameWeek(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .weekOfYear) == .orderedSame
    }

    func sameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(self, to: date, toGranularity: .month) == .orderedSame
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

    var startOfYear: Date {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.year], from: self)
        let date = calendar.date(from: components)!
    
        return date
    }

    var endOfYear: Date {
        let year = Calendar.autoupdatingCurrent.component(.year, from: self)
        print(year)
        let calendar = Calendar.init(identifier: .gregorian)
        let interval = calendar.dateInterval(of: .year, for: Date.init())!
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        
        var components = DateComponents()
        components.year = year
        components.day = days
        
        let date = Calendar.autoupdatingCurrent.date(from: components)!
        return date
    }

    var nextDay: Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.day = +1
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

