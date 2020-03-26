//
//  CitiesViewController.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 3/17/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CitiesViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!

    private var viewModel = CitiesViewModel()
    private let dataSource = CitiesDataSource()
    private let disposeBag = DisposeBag()

    private let selectedCityPublishSubject = PublishSubject<City>()
    var selectedCityObservable: Observable<City> {
        return selectedCityPublishSubject.asObserver()
    }

    override func loadView() {
        super.loadView()
        title = "Weather Reactive App"

        viewModel.errorMessageObservable
            .subscribe(onNext: { [weak self] message in
                guard let `self` = self else { return }
                AlertControllerRx(actions: [AlertAction.action(title: "Ok")])
                    .showAlert(from: self, title: "Error", message: message)
                    .subscribe()
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        viewModel.citiesObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        tableView.rx
            .modelSelected(City.self)
            .subscribe(onNext: { [weak self] city in
                self?.selectedCityPublishSubject.onNext(city)
            })
            .disposed(by: disposeBag)

        viewModel.requestCities()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CityTableViewCell.nib(), forCellReuseIdentifier: CityTableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }

}

// MARK: - Table view delegate

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CityTableViewCell.height
    }

}
