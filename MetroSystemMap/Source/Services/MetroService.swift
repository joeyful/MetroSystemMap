//
//  MetroService.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation


class MetroService {

    private let api : API
    private let connectionRetryLimit = 2

    init(api : API) {
        self.api = api
    }
    
    convenience init() {
        self.init(api: MetroAPI())
    }
    
    func vehicles(id: String, retryCount: Int = 0, responseQueue: DispatchQueue = .main, success : @escaping (VehicleResponse)->Void, error errorCallback:  @escaping (String) -> Void)  {
        
        let request = APIRequest(.get, path: "routes/\(id)/vehicles")
        
        api.send(request, success: { (result, url) in
            responseQueue.async {
                success(result)
            }
        }, error: { [weak self] error in
            guard let StrongSelf = self else { return }
            if retryCount < StrongSelf.connectionRetryLimit {
                responseQueue.asyncAfter(deadline: .now() + StrongSelf.retryTimeInterval(forRetryCount: retryCount)) {
                    StrongSelf.vehicles(id: id, retryCount: retryCount + 1, responseQueue: responseQueue, success: success, error: errorCallback)
                }
            } else {
                responseQueue.async {
                    errorCallback(error)
                }
            }
        })
    }
    
    func routes(retryCount: Int = 0, responseQueue: DispatchQueue = .main, success: @escaping (RouteResponse) -> Void, error errorCallback: @escaping (String) -> Void) {
        
        let request = APIRequest(.get, path: "routes")
        
        api.send(request, success: { (result, url) in
            responseQueue.async {
                success(result)
            }
        }, error: { [weak self] error in
            guard let StrongSelf = self else { return }
            if retryCount < StrongSelf.connectionRetryLimit {
                responseQueue.asyncAfter(deadline: .now() + StrongSelf.retryTimeInterval(forRetryCount: retryCount)) {
                    StrongSelf.routes(retryCount: retryCount + 1, responseQueue: responseQueue, success: success, error: errorCallback)
                }
            } else {
                responseQueue.async {
                    errorCallback(error)
                }
            }
        })
    }
    
    private func retryTimeInterval(forRetryCount retryCount : Int) -> DispatchTimeInterval {
        return .milliseconds(500 * (retryCount ^ 2))
    }
}
