//
//  Route.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 3/29/18.
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
    
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "display_name"
    }
}
