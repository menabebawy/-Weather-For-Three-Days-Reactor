//
//  NextDayTableViewCell.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/8/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

final class NextDayTableViewCell: UITableViewCell {
    @IBOutlet weak private var dayLabel: UILabel!
    @IBOutlet weak private var minTemperaturrLabel: UILabel!
    @IBOutlet weak private var maxTemperatureLabel: UILabel!

    static let identifier = "NextDayCell"
    static let height: CGFloat = 60

    func configure(forecast: Forecast) {
        dayLabel.text = forecast.day
        minTemperaturrLabel.text = forecast.main.celsiusMin()
        maxTemperatureLabel.text = forecast.main.celsiusMax()
    }

}
