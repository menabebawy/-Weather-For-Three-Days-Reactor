//
//  CitiesDataSource.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/18/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import RxDataSources

final class CitiesDataSource: RxTableViewSectionedReloadDataSource<CitiesSection> {

    init() {
        super.init(configureCell: { (_, tableView, indexPath, city) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
                    return UITableViewCell()
            }
            cell.configure(city: city)
            return cell
        })
    }

}
