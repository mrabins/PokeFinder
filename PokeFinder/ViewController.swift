//
//  ViewController.swift
//  PokeFinder
//
//  Created by Mark Rabins on 1/25/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var geoFire: GeoFire!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
    
}


// MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
}
