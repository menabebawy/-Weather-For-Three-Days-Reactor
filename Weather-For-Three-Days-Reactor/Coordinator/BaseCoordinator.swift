//
//  BaseCoordinator.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/21/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    unowned let navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        preconditionFailure("This method must be overriden")
    }
}
