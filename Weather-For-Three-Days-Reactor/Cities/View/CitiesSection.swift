//
//  CitiesSection.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/18/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxDataSources

struct CitiesSection {
    var header: String
    var items: [City]
}

extension CitiesSection: SectionModelType {
    typealias Item = City
    init(original: CitiesSection, items: [Item]) {
        self = original
        self.items = items
    }
}
