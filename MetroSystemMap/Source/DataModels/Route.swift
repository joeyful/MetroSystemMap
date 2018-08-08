//
//  Route.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import Foundation

struct RouteResponse : Codable {
    let routes: [Route]
    
    enum CodingKeys: String, CodingKey {
        case routes = "items"
    }
}

struct Route : Codable {
    
    let uid : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case name = "display_name"
    }
}
