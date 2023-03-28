//
//  LocationManager.swift
//  Kuber
//
//  Created by Timi on 15/2/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //gives us the most accurate possible location for the user location
        locationManager.requestWhenInUseAuthorization() //call in order to request location
        locationManager.startUpdatingLocation() //updates so we can start using location/
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didupdateLocations locations: [CLLocation]) {
        print("DEBUG: Locations are:  \(locations)")
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
