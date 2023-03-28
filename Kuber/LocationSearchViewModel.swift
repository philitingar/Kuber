//
//  LocationSearchViewModel.swift
//  Kuber
//
//  Created by Timi on 23/2/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]() //A fully formed string that completes a partial string.For ex if you start typing in search bar some string it will try completing the string. In our case we will use it to complete nearby places.
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D? // if the user selects something we are going to populate this property
    private let searchCompleter = MKLocalSearchCompleter() //A utility object for generating a list of completion strings based on a partial search string that you provide.
    var queryFragment: String = "" {
        didSet { 
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment//what it is what the search completer uses to search for all those locations
    }
    //MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG: Location coordinates are \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        print("DEBUG-DEBUG: Search is \(search)")
    }
    
    func computeRidePrice(forType type: RideType) -> Double { // gets the distance between users location and destination location
        guard let destCoordinate = selectedLocationCoordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 1.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        let tripDistanceInMeters = userLocation.distance(from: destination)
        print("DEBUG-DEBUG: USerLocation is \(userLocation)")
        return type.computePrice(for: tripDistanceInMeters)
    }
}
//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
