//
//  UIView+Extension.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/18/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

public extension UIView {

    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: Bundle(for: self))
    }

}
