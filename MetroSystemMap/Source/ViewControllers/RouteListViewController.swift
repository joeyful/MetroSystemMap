//
//  RouteListViewController.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 8/7/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit

class RouteListViewController: UIViewController {

    private let metroController = MetroController.shared
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView        : UITableView!
    @IBOutlet private weak var loadingGuardView : UIView!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.autoSize()
        loadList()
        
    }
}

// MARK: - Helper

private extension RouteListViewController {
    
    func loadList() {
        loadingGuardView?.fadeIn()
        metroController.loadRoutes(success: { [weak self] in
            guard let StrongSelf = self else { return }
            StrongSelf.tableView?.reloadData()
            StrongSelf.loadingGuardView?.fadeOut()
        },
        error: { [weak self] error in
            guard let StrongSelf = self else { return }
            StrongSelf.presentAlert(title: NSLocalizedString("Error", comment: "error alert title"), message: error)
            StrongSelf.loadingGuardView?.fadeOut()
        })
    }
    
    func presentDetailView(route: Route) {
        if let routeDetailViewController = RouteDetailViewController.buildFromStoryboard() {
            routeDetailViewController.route = route
            routeDetailViewController.modalTransitionStyle = .crossDissolve
            present(routeDetailViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension RouteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metroController.routeCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let route = metroController.routes[indexPath.row]
        presentDetailView(route: route)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListTableViewCell", for: indexPath)
        
        if let routeCell = cell as? RouteListTableViewCell, indexPath.row < metroController.routes.count {
            let route = metroController.routes[indexPath.row]
            routeCell.route = route
        }
        
        return cell
    }
    
}
