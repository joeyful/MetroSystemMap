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
    
    // MARK: - Public Property

    var routeCount: Int {
        return routes.count
    }
    
    var vehicleCount: Int {
        return vehicles.count
    }
    
    var center :CLLocation {
        return vehicleCount > 0 ? CLLocation(latitude:(maxLat + minLat) * 0.5, longitude: (maxLong + minLong) * 0.5) : CLLocation(latitude: defaultLat, longitude: defaultLong)
    }
    
    var regionRadius :CLLocationDistance {
        
        guard vehicleCount > 0  else { return defaultRadius }
        
        let coordinateMaxLong = CLLocation(latitude: defaultLat, longitude: maxLong)
        let coordinateMinLong = CLLocation(latitude: defaultLat, longitude: minLong)
        let distanceLong = coordinateMaxLong.distance(from: coordinateMinLong)

        let coordinateMaxLat = CLLocation(latitude: maxLat, longitude: defaultLong)
        let coordinateMinLat = CLLocation(latitude: minLat, longitude: defaultLong)
        let distanceLat = coordinateMaxLat.distance(from: coordinateMinLat)
        
        return max(distanceLong, distanceLat) * 1.2
    }
    
    // MARK: - Read Only Property

    private(set) var routes = [Route]()
    
    private(set) var vehicles = [Vehicle]() {
        didSet {
            calculateMapProperties()
        }
    }
    
    // MARK: - Private Property

    private var maxLat = -90.0
    private var minLat = 90.0
    private var maxLong = -180.0
    private var minLong = 180.0

    private let defaultLong = -118.2365021
    private let defaultLat  = 34.056219
    private let defaultRadius : CLLocationDistance = 50000

    
    // MARK: - Singleton
    
    static let shared = MetroController()
    private let service = MetroService()
    private init() {
        
    }
}


// MARK: - Helper

private extension MetroController {
    
    func calculateMapProperties() {
        resetMapProperties()
        
        vehicles.forEach() {
            minLat  = $0.latitude  < minLat  ? $0.latitude : minLat
            maxLat  = $0.latitude  > maxLat  ? $0.latitude : maxLat
            minLong = $0.longitude < minLong ? $0.longitude : minLong
            maxLong = $0.longitude > maxLong ? $0.longitude : maxLong
        }
    }

    func resetMapProperties() {
        maxLat = -90.0
        minLat = 90.0
        maxLong = -180.0
        minLong = 180.0
    }
}

// MARK: - Public API

extension MetroController {
    
    func loadRoutes(success: @escaping () -> Void, error errorHandle: @escaping (String) -> Void) {
        service.routes(success: { [weak self] result in
            guard let StrongSelf = self else { return }
            StrongSelf.routes = result.routes
            success()
        }, error: { error in
            errorHandle(error)
        })
    }
    
    func loadVehicles(for id: String, success: @escaping () -> Void, error errorHandle: @escaping (String) -> Void) {
        service.vehicles(id: id, success: { [weak self] result in
            guard let StrongSelf = self else { return }
            StrongSelf.vehicles = result.vehicles
            success()
        }, error: { error in
            errorHandle(error)
        })
    }
}
