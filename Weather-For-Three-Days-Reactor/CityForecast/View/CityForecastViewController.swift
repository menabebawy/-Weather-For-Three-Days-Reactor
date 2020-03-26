//
//  CityForecastViewController.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RxSwift

final class CityForecastViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!

    private let viewModel = CityForecastViewModel()
    private let dataSource = CityForecastDataSource()
    private let disposeBag = DisposeBag()

    var city: City!

    override public func loadView() {
        super.loadView()
        title = city.name

        viewModel.errorMessageObservable
            .subscribe(onNext: { [weak self] message in
                guard let `self` = self else { return }
                AlertControllerRx(actions: [AlertAction.action(title: "Ok")])
                    .showAlert(from: self, title: "Error", message: message)
                    .subscribe()
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        viewModel.hourlyForecastObservable
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
            })
            .disposed(by: disposeBag)

        viewModel.nextDaysForecastObservable
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadSections([2], with: .none)
            })
            .disposed(by: disposeBag)

        viewModel.sectionsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].model
        }

        viewModel.requestForecast(by: city)
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
