//
//  DateAdaptee.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

struct DateAdaptee {
    let since1970: Double
    let timeZone: Int

    init(since1970: Double, timeZone: Int) {
        self.since1970 = since1970
        self.timeZone = timeZone
    }

}
