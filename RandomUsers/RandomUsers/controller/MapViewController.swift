//
//  MapViewController.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/28/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class MapViewController: UIViewController,  MKMapViewDelegate {
    
    var latitude: Double?
    var longitude: Double?

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoacation()
    }
    

    private func setLoacation() {
        if let latitude = latitude,
            let longitude = longitude {
            
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
            let pin = CustomPin(coordinate: location)
            mapView.addAnnotation(pin)
            mapView.setRegion(region, animated: true)
        }
    }

}
