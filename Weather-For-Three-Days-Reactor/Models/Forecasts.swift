//
//  Forecasts.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

struct Forecasts: Decodable {
    let cnt: Int
    let list: [Forecast]
}
