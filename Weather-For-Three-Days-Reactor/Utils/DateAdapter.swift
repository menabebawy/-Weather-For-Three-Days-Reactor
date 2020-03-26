//
//  DateAdapter.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct DateAdapter {
    private let dateAdaptee: DateAdaptee

    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: dateAdaptee.timeZone)!
        return calendar
    }

    private var currentDate: Date {
        Date()
    }

    private var epochDate: Date {
        Date(timeIntervalSince1970: dateAdaptee.since1970)
    }

    private var currentDayComponent: Int {
        calendar.component(.day, from: currentDate)
    }

    private var epochDayComponent: Int {
        calendar.component(.day, from: epochDate)
    }

    private var epochHourComponent: Int {
        calendar.component(.hour, from: epochDate)
    }

    private var epochWeekDay: Int {
        calendar.component(.weekday, from: epochDate)
    }

    public init(dateAdaptee: DateAdaptee) {
        self.dateAdaptee = dateAdaptee
    }

    private func epochDayName() -> String {
        switch epochWeekDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "NA"
        }
    }

}

// MARK: - Forecast date adapter

extension DateAdapter: ForecastDateAdapter {
    public var hour: String {
        epochHourComponent >= 12 ? "\(epochHourComponent - 12)pm" :  "\(epochHourComponent)am"
    }

    public var day: String {
        epochDayName()
    }

    public var isCurrentDay: Bool {
        currentDayComponent == epochDayComponent
    }

    public func isNext(daysValue: Int) -> Bool {
        let nextdate = calendar.date(byAdding: .day, value: daysValue, to: currentDate)!
        let epochDate = Date(timeIntervalSince1970: dateAdaptee.since1970)

        let nextDateDay = calendar.component(.day, from: nextdate)
        let nextDateMonth = calendar.component(.month, from: nextdate)
        let nextDateYear = calendar.component(.year, from: nextdate)

        let epochDay = calendar.component(.day, from: epochDate)
        let epochMonth = calendar.component(.month, from: epochDate)
        let epochYear = calendar.component(.year, from: epochDate)

        return  nextDateDay == epochDay &&
            nextDateMonth == epochMonth &&
            nextDateYear == epochYear
    }

}
