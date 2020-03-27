//
//  Startup.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/27/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

struct Startup {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func build() -> [StartupCommand] {
        var commands: [StartupCommand] = []
        let firstViewControllerCommand = FirstViewControllerCommand(navigationController: navigationController)
        commands.append(firstViewControllerCommand)
        return commands
    }

}
