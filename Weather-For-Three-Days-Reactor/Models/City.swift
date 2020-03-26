//
//  City.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct City: Decodable {
    public let id: Int
    public let system: System
    public let date: Double
    public let name: String
    public let weather: [Weather]
    public let main: Main

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case system = "sys"
        case date = "dt"
        case name = "name"
        case weather = "weather"
        case main = "main"
    }

}
