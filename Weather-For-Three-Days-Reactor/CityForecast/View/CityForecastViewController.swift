//
//  CityForecastViewController.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class CityForecastViewController: UIViewController, StoryboardView {
    @IBOutlet weak private var tableView: UITableView!

    private let dataSource = CityForecastDataSource()

    var disposeBag = DisposeBag()
    var city: City!

    override public func loadView() {
        super.loadView()
        title = city.name

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].model
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()

        tableView.register(CurrentTemperatureTableViewCell.nib(),
                           forCellReuseIdentifier: CurrentTemperatureTableViewCell.identifier)

        tableView.register(HourlyTableViewCell.nib(),
                           forCellReuseIdentifier: HourlyTableViewCell.identifier)

        tableView.register(NextDayTableViewCell.nib(),
                           forCellReuseIdentifier: NextDayTableViewCell.identifier)
    }

    func bind(reactor: CityForecastViewReactor) {
        // Action
        reactor.action.onNext(.loadCityForecasts(city))

        // State
        reactor.state
            .map { $0.errorMessage }
            .subscribe(onNext: { [weak self] message in
                guard !message.isEmpty, let `self` = self else { return }
                AlertControllerRx(actions: [AlertAction.action(title: "Ok")])
                    .showAlert(from: self, title: "Error", message: message)
                    .subscribe()
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.sectionsModels }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

// MARK: - Table view delegate

extension CityForecastViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CurrentTemperatureTableViewCell.height
        case 1:
            return HourlyTableViewCell.height
        default:
            return NextDayTableViewCell.height
        }
    }

}
