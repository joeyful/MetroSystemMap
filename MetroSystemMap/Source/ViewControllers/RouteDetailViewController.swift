//
//  RouteDetailViewController.swift
//  MetroSystemMap
//
//  Created by Joey Wei on 3/30/18.
//  Copyright © 2018 Joey Wei. All rights reserved.
//

import UIKit
import MapKit

class RouteDetailViewController: UIViewController {

    private let metroController = MetroController.shared

    var route: Route? {
        didSet {
            guard let id = route?.id else { return }
            loadMap(id)
        }
    }
    

    // MARK: - Outlets

    @IBOutlet private weak var refreshButton     : UIButton!
    @IBOutlet private weak var backButton        : UIButton!
    @IBOutlet private weak var nameLabel         : UILabel!
    @IBOutlet private weak var mapView           : MKMapView!

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
        refreshButton.setTitle(NSLocalizedString("Refresh", comment: "Refresh"), for: .normal)
        backButton.setTitle(NSLocalizedString("Back", comment: "Back"), for: .normal)
        nameLabel.text = route?.name
    }
    
    func loadMap(_ id: String) {
//        loadingGuardView?.fadeIn()
        metroController.loadMap(for: id, success: { [weak self] in
            guard let StrongSelf = self else { return }
            StrongSelf.centerMap(on: StrongSelf.metroController.center, regionRadius: StrongSelf.metroController.regionRadius)
            StrongSelf.addAnnotations()
//            StrongSelf.tableView?.reloadData()
//            StrongSelf.loadingGuardView?.fadeOut()
            },
         error: { [weak self] error in
            guard let StrongSelf = self else { return }
            StrongSelf.presentAlert(title: NSLocalizedString("Error", comment: "error alert title"), message: error)
//            StrongSelf.loadingGuardView?.fadeOut()
        })
    }
}


// MARK: - Map

private extension RouteDetailViewController {
    
    func centerMap(on location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotations() {
        mapView.removeAnnotations(self.mapView.annotations)
        metroController.vehicles.forEach() {
            let location = CLLocationCoordinate2D(latitude: $0.latitude,longitude: $0.longitude);
            let annotation = MKPointAnnotation();
            annotation.coordinate = location;
            mapView.addAnnotation(annotation);
        }
    }
}


// MARK: - Action

private extension RouteDetailViewController {
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func refresh(_ sender: Any) {
        guard let id = route?.id else { return }
        loadMap(id)
    }
}
