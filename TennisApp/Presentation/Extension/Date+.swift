//
//  Date+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//
// swiftlint:disable force_unwrapping

import Foundation

extension Date {

    var isInTheFuture: Bool { self > Date() }
    var isInThePast: Bool { self < Date() }

    struct Formatter {

        static let ddMMyyyy: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter
        }()
    }

    /// Date formatted as `yyyy-MM-dd HH:mm:ss`  (30-05-2027)
    var formattedyyyyMMddHHmmss: String { Date.Formatter.ddMMyyyy.string(from: self) }

    // MARK: Date Manipulation

    /// Returns a new Date object representing the date calculated by adding the amount specified to self date
    /// - Parameters:
    ///   - seconds: number of seconds to add
    ///   - minutes: number of minutes to add
    ///   - hours: number of hours to add
    ///   - days: number of days to add
    ///   - weeks: number of weeks to add
    ///   - months: number of months to add
    ///   - years: number of years to add
    /// - Returns: The new date
     func add(_ seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        let calendar = Calendar.current

        let version = floor(NSFoundationVersionNumber)

        if version <= NSFoundationVersionNumber10_9_2 {
            var component = DateComponents()
            (component as NSDateComponents).setValue(seconds, forComponent: .second)

            var date: Date! = (calendar as NSCalendar).date(byAdding: component, to: self, options: NSCalendar.Options.wrapComponents)!
            component = DateComponents()
            (component as NSDateComponents).setValue(minutes, forComponent: .minute)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(hours, forComponent: .hour)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(days, forComponent: .day)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(weeks, forComponent: .weekOfMonth)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(months, forComponent: .month)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(years, forComponent: .year)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!
            return date
        }

        var date: Date! = (calendar as NSCalendar).date(byAdding: .second, value: seconds, to: self, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .minute, value: minutes, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .day, value: days, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .hour, value: hours, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .weekOfMonth, value: weeks, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .month, value: months, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .year, value: years, to: date, options: NSCalendar.Options.wrapComponents)
        return date
    }

    func addSeconds (_ seconds: Int) -> Date {
        add(seconds)
    }

    func addMinutes (_ minutes: Int) -> Date {
        add(minutes: minutes)
    }

    func addHours(_ hours: Int) -> Date {
        add(hours: hours)
    }

    func addDays(_ days: Int) -> Date {
        add(days: days)
    }

    func addWeeks(_ weeks: Int) -> Date {
        add(weeks: weeks)
    }

    func addMonths(_ months: Int) -> Date {
        add(months: months)
    }

    func addYears(_ years: Int) -> Date {
        add(years: years)
    }

    // MARK: Date comparison

    func isAfter(_ date: Date) -> Bool {
        (self.compare(date) == ComparisonResult.orderedDescending)
    }

    func isBefore(_ date: Date) -> Bool {
        (self.compare(date) == ComparisonResult.orderedAscending)
    }
}

// swiftlint:enable force_unwrapping
