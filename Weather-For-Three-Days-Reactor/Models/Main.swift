//
//  Main.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Main: Decodable {
    let temperature: Float
    var min: Float!
    var max: Float!
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    func celsiusTemperature() -> String {
        toString(tem: temperature)
    }
    
    func celsiusMin() -> String {
        toString(tem: temperature)
    }
    
    func celsiusMax() -> String {
        toString(tem: max)
    }
    
    private func toString(tem: Float) -> String {
        String(format: "%.0f", tem) + "º"
    }
    
}
