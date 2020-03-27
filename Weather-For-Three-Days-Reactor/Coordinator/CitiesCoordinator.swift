//
//  CitiesCoordinator.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RxSwift

final class CitiesCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    
    override func start() {
        let nibName = String(describing: CitiesViewController.self)
        let citiesViewController = CitiesViewController(nibName: nibName, bundle: .main)
        citiesViewController.reactor = CitiesViewReactor()
        citiesViewController.selectedCityObservable
            .subscribe(onNext: { city in
                CityForecasCoordinator(navigationController: self.navigationController, city: city).start()
            })
            .disposed(by: disposeBag)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [citiesViewController]
    }
    
}
