//
//  MetroController.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 3/28/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation

final class MetroController {

    private(set) var routes = [Route]()
    
    var listCount: Int {
        return routes.count
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
}


// MARK: - Private Function

private extension MetroController {
    
    func route(success : @escaping  (RouteResponse)->Void , error errorCallback : @escaping  (String) -> Void) {
        service.route(success: success, error: errorCallback)
    }
}
