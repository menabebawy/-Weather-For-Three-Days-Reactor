//
//  Coordinator.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/6/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    init(navigationController: UINavigationController)

    func start()
}
