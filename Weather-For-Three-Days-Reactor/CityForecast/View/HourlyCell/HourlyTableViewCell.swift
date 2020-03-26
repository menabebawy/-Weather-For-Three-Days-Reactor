//
//  HourlyTableViewCell.swift
//  Weather-For-Three-Days-Reactor
//
//  Created by Mena Bebawy on 2/7/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class HourlyTableViewCell: UITableViewCell {
    @IBOutlet weak private var collectionView: UICollectionView!

    private var dataSubject = PublishSubject<[Forecast]>()
    private let disposeBag = DisposeBag()

    static let identifier = "HourlyCell"
    static let height: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(HourCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: HourCollectionViewCell.identifier)

        dataSubject.asObserver()
            .bind(to: collectionView.rx
                .items(cellIdentifier: HourCollectionViewCell.identifier,
                       cellType: HourCollectionViewCell.self)) { _, forecast, cell in
                        cell.configure(forecast)
        }
        .disposed(by: disposeBag)
    }

    func configure(forecasts: [Forecast]) {
        dataSubject.onNext(forecasts)
    }

}

// MARK: - Collection view delegate flow layout

extension HourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HourCollectionViewCell.width, height: HourCollectionViewCell.width)
    }

}
