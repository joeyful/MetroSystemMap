//
//  RouteListTableViewCell.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

class RouteListTableViewCell: UITableViewCell {

    var route : Route? {
        didSet {
            titleLabel.text = route?.name
        }
    }
    
    @IBOutlet private weak var titleLabel : UILabel!

}
