//
//  CityTableViewCell.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import Kingfisher

final class CityTableViewCell: UITableViewCell {
    @IBOutlet weak private var cityNameLabel: UILabel!
    @IBOutlet weak private var tempratureLabel: UILabel!
    @IBOutlet weak private var weatherImageView: UIImageView!

    static let identifier = "CityCell"
    static let height: CGFloat = 80

    func configure(city: City) {
        cityNameLabel.text = city.name
        tempratureLabel.text = city.main.celsiusTemperature()
        weatherImageView.kf.setImage(with: URL(string: city.weather[0].iconURL))
    }

}
