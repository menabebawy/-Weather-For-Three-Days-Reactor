//
//  DateAdaptee.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct DateAdaptee {
    public let since1970: Double
    public let timeZone: Int

    public init(since1970: Double, timeZone: Int) {
        self.since1970 = since1970
        self.timeZone = timeZone
    }

}
