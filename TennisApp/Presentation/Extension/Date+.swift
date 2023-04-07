//
//  Date+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//
// swiftlint:disable force_unwrapping

import Foundation

public extension Date {

    // MARK: NSDate Manipulation

    /**
     Returns a new NSDate object representing the date calculated by adding the amount specified to self date

     :param: seconds number of seconds to add
     :param: minutes number of minutes to add
     :param: hours number of hours to add
     :param: days number of days to add
     :param: weeks number of weeks to add
     :param: months number of months to add
     :param: years number of years to add
     :returns: the NSDate computed
     */
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

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date

     :param: seconds number of seconds to add
     :returns: the NSDate computed
     */
    func addSeconds (_ seconds: Int) -> Date {
        add(seconds)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date

     :param: minutes number of minutes to add
     :returns: the NSDate computed
     */
    func addMinutes (_ minutes: Int) -> Date {
        add(minutes: minutes)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date

     :param: hours number of hours to add
     :returns: the NSDate computed
     */
    func addHours(_ hours: Int) -> Date {
        add(hours: hours)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date

     :param: days number of days to add
     :returns: the NSDate computed
     */
    func addDays(_ days: Int) -> Date {
        add(days: days)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date

     :param: weeks number of weeks to add
     :returns: the NSDate computed
     */
    func addWeeks(_ weeks: Int) -> Date {
        add(weeks: weeks)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date

     :param: months number of months to add
     :returns: the NSDate computed
     */

    func addMonths(_ months: Int) -> Date {
        add(months: months)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date

     :param: years number of year to add
     :returns: the NSDate computed
     */
    func addYears(_ years: Int) -> Date {
        add(years: years)
    }

    // MARK: Date comparison

    /**
     Checks if self is after input NSDate

     :param: date NSDate to compare
     :returns: True if self is after the input NSDate, false otherwise
     */
    func isAfter(_ date: Date) -> Bool {
        (self.compare(date) == ComparisonResult.orderedDescending)
    }

    /**
     Checks if self is before input NSDate

     :param: date NSDate to compare
     :returns: True if self is before the input NSDate, false otherwise
     */
    func isBefore(_ date: Date) -> Bool {
        (self.compare(date) == ComparisonResult.orderedAscending)
    }
}

// swiftlint:enable force_unwrapping
