//
//  Route.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation

struct VehicleResponse : Codable {
    let vehicles: [Vehicle]
    
    enum CodingKeys: String, CodingKey {
        case vehicles = "items"
    }
}

struct Vehicle : Codable {
    
    let id : String
    let longitude : Double
    let latitude  : Double
}
