//
//  CityForecastDataSource.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/18/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxDataSources

enum CellModel {
    case current(City)
    case houly([Forecast])
    case nextDays(Forecast)
}

final class CityForecastDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>> {

    init() {
        super.init(configureCell: { _, tableView, indexPath, item in
            switch item {
            case .current(let city):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: CurrentTemperatureTableViewCell.identifier,
                    for: indexPath) as? CurrentTemperatureTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(city: city)
                return cell

            case .houly(let forecasts):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(forecasts: forecasts)
                return cell

            case .nextDays(let forecast):
                guard  let cell = tableView.dequeueReusableCell(
                    withIdentifier: NextDayTableViewCell.identifier, for: indexPath) as? NextDayTableViewCell else {
                        return UITableViewCell()
                }

                cell.configure(forecast: forecast)
                return cell
            }
        })
    }

}
