//
//  Forecasts.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Forecasts: Decodable {
    public let cnt: Int
    public let list: [Forecast]
}
