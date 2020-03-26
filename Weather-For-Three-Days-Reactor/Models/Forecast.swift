//
//  Forecast.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public protocol ForecastDateAdapter {
    var hour: String { get }
    var day: String { get }
    var isCurrentDay: Bool { get }

    func isNext(daysValue: Int) -> Bool
}

public struct Forecast: Decodable {
    public let date: Double
    public let weather: [Weather]
    public var main: Main
    public var dateAdapter: DateAdapter!

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case weather = "weather"
        case main = "main"
    }

}

extension Forecast: ForecastDateAdapter {
    public var day: String {
        dateAdapter.day
    }
    public var isCurrentDay: Bool {
        dateAdapter.isCurrentDay
    }

    /// Use thie property for hour in 12 mode, for example 10am, 10pm
    public var hour: String {
        dateAdapter.hour
    }

    public func isNext(daysValue: Int) -> Bool {
        dateAdapter.isNext(daysValue: daysValue)
    }

}
