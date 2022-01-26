//
//  MapKitScreenEntity.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 26.01.2022.
//

import YandexMapsMobile

class MapKitScreenEntity {
    private var driving: YMKDrivingSession?
    private var bicycle: YMKBicycleSession?
    private var masstransit: YMKMasstransitSession?
    var route: Route?

    var drivingSession: YMKDrivingSession? {
        get {
            driving
        } set {
            driving = newValue
            bicycle = nil
            masstransit = nil
        }
    }

    var bicycleSession: YMKBicycleSession? {
        get {
            bicycle
        } set {
            driving = nil
            bicycle = newValue
            masstransit = nil
        }
    }

    var masstransitSession: YMKMasstransitSession? {
        get {
            masstransit
        } set {
            driving = nil
            bicycle = nil
            masstransit = newValue
        }
    }

    func clear() {
        driving = nil
        bicycle = nil
        masstransit = nil
        route = nil
    }
}
