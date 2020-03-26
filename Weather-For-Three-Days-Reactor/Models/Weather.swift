//
//  Weather.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Weather: Decodable {
    public let id: Int
    public let main: String
    let icon: String

    private var baseIconUrl: String {
        "http://openweathermap.org/img/wn/"
    }

    public var iconURL: String {
        baseIconUrl + icon + ".png"
    }

    public var icon2XUrl: String {
        baseIconUrl + icon + "@2x.png"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case icon
    }

}
