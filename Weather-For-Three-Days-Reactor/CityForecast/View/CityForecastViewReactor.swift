//
//  CityForecastViewReactor.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/27/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxSwift
import ReactorKit
import RxDataSources

final class CityForecastViewReactor: Reactor {

    enum Action {
        case loadCityForecasts(City)
    }

    enum Mutation {
        case setData([SectionModel<String, CellModel>])
        case setErrorMessage(String)
    }

    struct State {
        var sectionsModels: [SectionModel<String, CellModel>] = []
        var errorMessage = ""
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadCityForecasts(let city):
            return Observable<Mutation>.create { observer in
                RequestCall<Forecasts>(parameters: ["id": "\(city.id)"], path: "forecast").start { [weak self] result in
                    guard let `self` = self else { return }
                    result.onSuccess { forecasts in
                        observer.onNext(Mutation.setData(self.fetchedForecasts(forecasts.list, city: city)))
                    }.onError { error in
                        observer.onNext(Mutation.setErrorMessage(error.localizedDescription))
                    }
                }
                return Disposables.create()
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .setData(let sectionsModel):
            state.sectionsModels = sectionsModel
        case .setErrorMessage(let message):
            state.errorMessage = message
        }

        return state
    }

    private func fetchedForecasts(_ forecasts: [Forecast], city: City) -> [SectionModel<String, CellModel>] {
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

        return ([
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
