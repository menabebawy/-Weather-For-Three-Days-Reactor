//
//  RequestCall.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/17/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation
import Endpoints

struct RequestCall<T: Decodable>: Call {
    typealias Parser = JSONParser<T>

    private var baseURL: String {
        "http://api.openweathermap.org/data/2.5/"
    }

    var parameters: [String: String]
    var path: String

    var request: URLRequestEncodable {
        var query = parameters
        query["units"] = "metric"
        query["APPID"] = "7764fcb1cae95e2051b8d0bba8c7d962"
        return Request(.get, path, query: query)
    }

    func start(completion: @escaping (Result<Parser.OutputType>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.init(response: .none))
            return
        }

        let session = Session(with: AnyClient(baseURL: url))
        session.start(call: self, completion: completion)
    }

}
