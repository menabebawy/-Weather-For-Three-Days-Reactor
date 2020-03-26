//
//  AlertControllerRx.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/21/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxSwift
import RxCocoa

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style

    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }

}

struct AlertControllerRx {
    var actions: [AlertAction]

    func showAlert(from viewController: UIViewController, title: String?, message: String?) -> Observable<Int> {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            self.actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }

            viewController.present(alertController, animated: true, completion: nil)

            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }

}
