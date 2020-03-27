//
//  Cities.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation
import Endpoints

struct Cities: Decodable {
    let cnt: Int
    let list: [City]
}

extension Cities {
    
    static func ids() -> String {
        [360630: "Cairo",
         2761369: "Vienna",
         2950159: "Berlin",
         2988507: "Paris",
         3117735: "Madrid",
         2673730: "Stockholm",
         2643743: "London",
         250441: "Amman",
         6077243: "Montreal",
         6167865: "Tronto"].map { "\($0.key)" }.joined(separator: ",")
    }
    
}
