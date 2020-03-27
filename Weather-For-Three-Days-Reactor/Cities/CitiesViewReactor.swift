//
//  CitiesViewReactor.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/26/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import ReactorKit
import RxSwift

final class CitiesViewReactor: Reactor {

    enum Action {
        case loadCities
    }

    enum Mutation {
        case setCities([CitiesSection])
        case setErrorMessage(String)
    }

    struct State {
        var citiesSections: [CitiesSection] = []
        var errorMessage = ""
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadCities:
            return Observable<Mutation>.create { observer in
                RequestCall<Cities>(parameters: ["id": Cities.ids()], path: "group").start { result in
                    result.onSuccess { cities in
                        observer.onNext(Mutation.setCities([CitiesSection(header: "Cities", items: cities.list)]))
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
        case .setCities(let citiesSections):
            state.citiesSections = citiesSections
        case .setErrorMessage(let message):
            state.errorMessage = message
        }

        return state
    }

}
