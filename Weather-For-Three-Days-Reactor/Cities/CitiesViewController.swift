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
import ReactorKit

final class CitiesViewController: UIViewController, StoryboardView {
    @IBOutlet weak private var tableView: UITableView!

    private let dataSource = CitiesDataSource()
    private let selectedCityPublishSubject = PublishSubject<City>()

    var selectedCityObservable: Observable<City> {
        return selectedCityPublishSubject.asObserver()
    }

    var disposeBag: DisposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        title = "Weather Reactive App"

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        tableView.rx
            .modelSelected(City.self)
            .subscribe(onNext: { [weak self] city in
                self?.selectedCityPublishSubject.onNext(city)
            })
            .disposed(by: disposeBag)
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

    func bind(reactor: CitiesViewReactor) {
        // Action
        reactor.action.onNext(.loadCities)

        // State
        reactor.state
            .map { $0.errorMessage}
            .subscribe(onNext: { [weak self] message in
                guard !message.isEmpty, let `self` = self else { return }
                AlertControllerRx(actions: [AlertAction.action(title: "Ok")])
                    .showAlert(from: self, title: "Error", message: message)
                    .subscribe()
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.citiesSections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

// MARK: - Table view delegate

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CityTableViewCell.height
    }

}
