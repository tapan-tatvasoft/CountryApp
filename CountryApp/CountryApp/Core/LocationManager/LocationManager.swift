//
//  LocationManager.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, LocationProviding {
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
        private var lastGeocodingRequest: Date?

    @Published var currentCountryCode: String?
    @Published var countryName: String?

    var currentCountryCodePublisher: Published<String?>.Publisher {
        $currentCountryCode
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.last else { return }
        
        let now = Date()
        if let last = lastGeocodingRequest, now.timeIntervalSince(last) < 1.5 {
            // Skip to prevent throttling
            return
        }
        
        lastGeocodingRequest = now
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(latest) { placemarks, _ in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.currentCountryCode = placemark.isoCountryCode
                    self.countryName = placemark.country
                }
            }
        }
    }
}

