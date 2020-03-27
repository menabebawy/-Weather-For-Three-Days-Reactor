//
//  FirstViewControllerCommand.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Beabawy on 3/27/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

struct FirstViewControllerCommand: StartupCommand {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func execute() {
        CitiesCoordinator(navigationController: navigationController).start()
    }

}

