//
//  CityForecastViewModel.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/18/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxSwift
import RxDataSources

struct CityForecastViewModel {
    private let hourlyForecastSubject = PublishSubject<[Forecast]>()
    var hourlyForecastObservable: Observable<[Forecast]> {
        hourlyForecastSubject.asObserver()
    }

    private let nextDaysForecastSubject = PublishSubject<[Forecast]>()
    var nextDaysForecastObservable: Observable<[Forecast]> {
        nextDaysForecastSubject.asObserver()
    }

    private let sectionsSubject = PublishSubject<[SectionModel<String, CellModel>]>()
    var sectionsObservable: Observable<[SectionModel<String, CellModel>]> {
        sectionsSubject.asObserver()
    }

    private let errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject.asObserver()
    }

    func requestForecast(by city: City) {
        RequestCall<Forecasts>(parameters: ["id": "\(city.id)"], path: "forecast").start { result in
            result.onSuccess { forecasts in
                self.fetchedForecasts(forecasts.list, city: city)
            }.onError { error in
                self.errorMessageSubject.onNext(error.localizedDescription)
            }
        }
    }

    func fetchedForecasts(_ forecasts: [Forecast], city: City) {
        var forecasts = forecasts
        let timeZone = city.system.timeZone

        // Assign dateAdapter property
        forecasts.mutateEach { $0.dateAdapter = DateAdapter(
            dateAdaptee: DateAdaptee(since1970: $0.date, timeZone: timeZone)) }

        // Update next 3 days
        let nextOneDayResult = forecasts.filter { $0.isNext(daysValue: 1) }
        let nextTwoDaysResult = forecasts.filter { $0.isNext(daysValue: 2) }
        let nextThreeDaysResult = forecasts.filter { $0.isNext(daysValue: 3) }

        let currentForecasts = forecasts.filter { $0.isCurrentDay }
        let nextThreeDaysForcasts = [nextDayForecast(for: nextOneDayResult),
                                     nextDayForecast(for: nextTwoDaysResult),
                                     nextDayForecast(for: nextThreeDaysResult)]

        sectionsSubject.onNext([
            SectionModel(model: "Now", items: [CellModel.current(city)]),
            SectionModel(model: "Hourly", items: [CellModel.houly(currentForecasts)]),
            SectionModel(model: "Next 3 days", items: nextThreeDaysForcasts.map { CellModel.nextDays($0) })
        ])
    }

    private func nextDayForecast(for forecasts: [Forecast]) -> Forecast {
        var newForecast = forecasts.first!
        let temperatures = forecasts.map { $0.main.temperature }
        newForecast.main.min = temperatures.sorted(by: <).first!
        newForecast.main.max = temperatures.sorted(by: >).first!
        return newForecast
    }
}
