//
//  EBLocationManager.swift
//  EBWeatherApp
//
//  Created by product on 17/11/2019.
//  Copyright © 2019 AAStocks. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift

class EBLocationManager {
    static let shared = EBLocationManager()
    private(set) var authorizationStatus: Driver<CLAuthorizationStatus>
    private(set) var location: Driver<CLLocationCoordinate2D>

    private let locationManager = CLLocationManager()

    private init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        authorizationStatus = Observable.deferred { [weak locationManager] in
            let status = CLLocationManager.authorizationStatus()
            guard let locationManager = locationManager else {
                return Observable.just(status)
            }
            return locationManager.rx.didChangeAuthorizationStatus.startWith(status)
        }
        .asDriver(onErrorJustReturn: CLAuthorizationStatus.notDetermined)

        location = locationManager.rx.didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                $0.last.map(Driver.just) ?? Driver.empty()
            }
            .map { $0.coordinate }
    }

    func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
