//
//  UIView+Shadow.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

extension UIView {
    
    func showShadow() {
        layer.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:35.00).cgColor
        layer.shadowOpacity = 0.45
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 5.0
    }
    
    func hideShadow() {
        layer.shadowOpacity = 0.0
    }
    
}
