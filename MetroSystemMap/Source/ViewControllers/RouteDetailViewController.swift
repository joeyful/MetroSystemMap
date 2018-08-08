//
//  RouteDetailViewController.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 3/30/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

class RouteDetailViewController: UIViewController {

    var name: String?

    var uid: String? {
        didSet {

        }
    }
    

    // MARK: - Outlets

    @IBOutlet private weak var refreshButton     : UIButton?
    @IBOutlet private weak var backButton        : UIButton?
    @IBOutlet private weak var loadingGuardView  : UIView?
    
    // MARK: - Class Function

    class func buildFromStoryboard() -> RouteDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let routeDetailViewController = storyboard.instantiateViewController(withIdentifier:  "RouteDetailVC") as? RouteDetailViewController else { return nil }
        return  routeDetailViewController
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
}


// MARK: - Helper

private extension RouteDetailViewController {
    
    func setupUserInterface() {
        refreshButton?.setTitle(NSLocalizedString("Refresh", comment: "Refresh"), for: .normal)
        backButton?.setTitle(NSLocalizedString("Back", comment: "Back"), for: .normal)
    }
}

// MARK: - Action

private extension RouteDetailViewController {
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func refresh(_ sender: Any) {

    }
}
