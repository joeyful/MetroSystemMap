//
//  RoundButton.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit



class RoundButton: UIButton {
    
    enum ButtonState { case enabled, disabled, inProgress }

    var buttonState : ButtonState = .enabled {
        didSet {
            updateButtonState()
        }
    }
    
    private let activityIndicatorView = UIActivityIndicatorView()
    
    private var enabledBackgroundColor : UIColor = .orange
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        if let backgroundColor = backgroundColor {
            enabledBackgroundColor = backgroundColor
        }
        
        layer.cornerRadius = 8.0
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.darkGray, for: .disabled)
        setImage(nil, for: .disabled)
        
        activityIndicatorView.activityIndicatorViewStyle = .white
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicatorView)
        addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        buttonState = isEnabled ? .enabled : .disabled
    }
    
    private func showEnabledState() {
        activityIndicatorView.stopAnimating()
        backgroundColor = enabledBackgroundColor
        showShadow()
    }
    
    private func showDisabledState() {
        activityIndicatorView.stopAnimating()
        setTitle(title(for: .normal), for: .disabled)  // use normal title for disabled state
        backgroundColor = .lightGray
        hideShadow()
    }
    
    private func showInProgressState() {
        activityIndicatorView.startAnimating()
        setTitle("", for: .disabled) // hide title
        backgroundColor = enabledBackgroundColor
        showShadow()
    }
    
    private func updateButtonState() {
        
        isEnabled = (buttonState == .enabled)
        
        switch buttonState {
        case .enabled:
            showEnabledState()
            
        case .disabled:
            showDisabledState()
            
        case .inProgress:
            showInProgressState()
        }
    }

}
