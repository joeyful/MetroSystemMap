//
//  MetroController.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation
import MapKit

final class MetroController {
    
    let defaultLong = -118.2365021
    let defaultLat  = 34.056219
    
    var routeCount: Int {
        return routes.count
    }
    
    var center :CLLocation {
        return vehicleCount > 0 ? CLLocation(latitude:(maxLat + minLat) * 0.5, longitude: (maxLong + minLong) * 0.5) : CLLocation(latitude: defaultLat, longitude: defaultLong)
    }
    
    var regionRadius :CLLocationDistance {
        
        guard vehicleCount > 0  else { return 50000 }
        
        let coordinateX0 = CLLocation(latitude: defaultLat, longitude: maxLong)
        let coordinateX1 = CLLocation(latitude: defaultLat, longitude: minLong)
        let distanceX = coordinateX0.distance(from: coordinateX1)

        let coordinateY0 = CLLocation(latitude: maxLat, longitude: defaultLong)
        let coordinateY1 = CLLocation(latitude: minLat, longitude: defaultLong)
        let distanceY = coordinateY0.distance(from: coordinateY1)
        return max(distanceX, distanceY) * 1.2
    }
    
    private(set) var routes = [Route]()
    
    private(set) var vehicles = [Vehicle]() {
        didSet {
            calculateMapProperties()
        }
    }
    
    private var maxLat = -90.0
    private var minLat = 90.0
    private var maxLong = -180.0
    private var minLong = 180.0
    
    private var vehicleCount: Int {
        return vehicles.count
    }

    
    // MARK: - Singleton
    
    static let shared = MetroController()
    private let service = MetroService()
    private init() {
        
    }
}


// MARK: - Public API

extension MetroController {
    
    func loadList(success: @escaping () -> Void, error errorHandle: @escaping (String) -> Void) {
        MetroController.shared.route(success: { [weak self] result in
            guard let StrongSelf = self else { return }
            StrongSelf.routes = result.routes
            success()
        }, error: { error in
            errorHandle(error)
        })
    }
    
    func loadMap(for id: String, success: @escaping () -> Void, error errorHandle: @escaping (String) -> Void) {
        MetroController.shared.vehicle(id: id, success: { [weak self] result in
            guard let StrongSelf = self else { return }
            StrongSelf.vehicles = result.vehicles
            success()
        }, error: { error in
                errorHandle(error)
        })
    }
}


// MARK: - Private Function

private extension MetroController {
    
    func route(success : @escaping  (RouteResponse)->Void , error errorCallback : @escaping  (String) -> Void) {
        service.route(success: success, error: errorCallback)
    }
    
    func vehicle(id: String, success : @escaping  (VehicleResponse)->Void , error errorCallback : @escaping  (String) -> Void) {
        service.vehicles(id: id, success: success, error: errorCallback)
    }
    
    func calculateMapProperties() {
        
        maxLat = -90.0
        minLat = 90.0
        maxLong = -180.0
        minLong = 180.0
        
        vehicles.forEach() {
            if $0.latitude < minLat {
                minLat = $0.latitude
            }
            if $0.latitude > maxLat {
                maxLat = $0.latitude
            }
            if $0.longitude < minLong {
                minLong = $0.longitude
            }
            if $0.longitude > maxLong {
                maxLong = $0.longitude
            }
        }
    }
}
