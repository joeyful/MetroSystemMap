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
        
        setupUserInterface()
        loadList()
        
    }
}

// MARK: - Helper

private extension RouteListViewController {
    
    func setupUserInterface() {
        tableView.autoSize()
    }
    
    func updateUserInterface() {
        tableView?.reloadData()
    }
    
    func loadList() {
        loadingGuardView?.fadeIn()
        metroController.loadList(success: { [weak self] in
            guard let StrongSelf = self else { return }
            StrongSelf.updateUserInterface()
            StrongSelf.loadingGuardView?.fadeOut()
        },
        error: { [weak self] error in
            guard let StrongSelf = self else { return }
            StrongSelf.presentAlert(title: NSLocalizedString("Error", comment: "error alert title"), message: error)
            StrongSelf.loadingGuardView?.fadeOut()
        })
    }
}

// MARK: - UITableViewDataSource

extension RouteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metroController.listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListTableViewCell", for: indexPath)
        let routes = metroController.routes
        
        if let routeCell = cell as? RouteListTableViewCell, indexPath.row < routes.count {
            let route = routes[indexPath.row]
            populate(routeCell, with: route)
        }
        
        return cell
    }
    
    private func populate(_ cell: RouteListTableViewCell, with route: Route) {
        cell.delegate = self
        cell.route = route
    }
}

// MARK: - RedditTopListTableViewCellDelegate

extension RouteListViewController: RouteListTableViewCellDelegate {
    func selectedRoute(on cell: RouteListTableViewCell) {
//        guard let uid = cell.uid, let name = cell.name else { return }
//        presentDetailView(uid: uid, name: name)
    }
}
