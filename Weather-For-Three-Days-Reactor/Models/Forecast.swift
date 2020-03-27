//
//  Forecast.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

protocol ForecastDateAdapter {
    var hour: String { get }
    var day: String { get }
    var isCurrentDay: Bool { get }
    
    func isNext(daysValue: Int) -> Bool
}

struct Forecast: Decodable {
    let date: Double
    let weather: [Weather]
    var main: Main
    var dateAdapter: DateAdapter!
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case weather = "weather"
        case main = "main"
    }
    
}

extension Forecast: ForecastDateAdapter {
    var day: String {
        dateAdapter.day
    }

    var isCurrentDay: Bool {
        dateAdapter.isCurrentDay
    }
    
    /// Use thie property for hour in 12 mode, for example 10am, 10pm
    var hour: String {
        dateAdapter.hour
    }
    
    func isNext(daysValue: Int) -> Bool {
        dateAdapter.isNext(daysValue: daysValue)
    }

}
