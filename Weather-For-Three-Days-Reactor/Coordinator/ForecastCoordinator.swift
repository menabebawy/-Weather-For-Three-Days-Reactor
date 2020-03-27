//
//  ForecastModuleCoordinator.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

final class CityForecasCoordinator: BaseCoordinator {
    private var city: City!

    convenience init(navigationController: UINavigationController, city: City) {
        self.init(navigationController: navigationController)
        self.city = city
    }

    override func start() {
        let nibName = String(describing: CityForecastViewController.self)
        let forecastViewController = CityForecastViewController(nibName: nibName, bundle: .main)
        forecastViewController.city = city
        forecastViewController.reactor = CityForecastViewReactor()
        navigationController.pushViewController(forecastViewController, animated: true)
    }

}
