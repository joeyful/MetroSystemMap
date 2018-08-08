//
//  RouteListTableViewCell.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 3/29/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

protocol RouteListTableViewCellDelegate: class {
    func selectedRoute(on cell: RouteListTableViewCell)
}

class RouteListTableViewCell: UITableViewCell {

    var route : Route? {
        didSet {
            titleLabel.text = route?.name
        }
    }
    
    weak var delegate : RouteListTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel           : UILabel!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }

    // MARK: - Action

    @IBAction func detail(_ button: UIButton) {
        delegate?.selectedRoute(on: self)
    }
}
