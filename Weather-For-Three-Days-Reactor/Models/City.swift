//
//  City.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

struct City: Decodable {
    let id: Int
    let system: System
    let date: Double
    let name: String
    let weather: [Weather]
    let main: Main
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case system = "sys"
        case date = "dt"
        case name = "name"
        case weather = "weather"
        case main = "main"
    }

}
