//
//  UITableView+AutoSize.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

extension UITableView {
    func autoSize(with estimatedRowHeight: CGFloat = 200) {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = estimatedRowHeight
    }
}
