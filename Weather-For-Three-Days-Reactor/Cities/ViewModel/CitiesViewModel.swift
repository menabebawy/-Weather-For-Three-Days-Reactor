//
//  CitiesViewModel.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/17/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation
import RxSwift

struct CitiesViewModel {
    private let citiesSubject = PublishSubject<[CitiesSection]>()
    var citiesObservable: Observable<[CitiesSection]> {
        return citiesSubject.asObserver()
    }

    private let errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject.asObserver()
    }

    func requestCities() {
        RequestCall<Cities>(parameters: ["id": Cities.ids()], path: "group").start { result in
            result.onSuccess { cities in
                self.citiesSubject.onNext([CitiesSection(header: "Cities", items: cities.list)])
            }.onError { error in
                self.errorMessageSubject.onNext(error.localizedDescription)
            }
        }
    }

}
