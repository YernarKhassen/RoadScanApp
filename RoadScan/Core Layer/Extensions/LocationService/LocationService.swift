//
//  LocationService\.swift
//  InRoad
//
//  Created by Dinmukhamed on 20.03.2023.
//

import CoreLocation

struct CurrentLocationModel {
    var lat: Double
    var lon: Double
}

protocol LocationServiceProtocol {
    func getCurrentLocation(with location: CurrentLocationModel)
}

protocol AlertProtocol {
    func grantPermission()
}

final class LocationService: NSObject {
    private var locationManager: CLLocationManager = CLLocationManager()
    
    var delegate: LocationServiceProtocol?
    var delegateAlert: AlertProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                print("yes")
            } else if status == .denied {
                delegateAlert?.grantPermission()
            }

        }
    func requestLocation(rate : Double) {
        locationManager.requestLocation()
    }
    
    func requestToAccess() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopMonitoringSignificantLocationChanges()
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        delegate?.getCurrentLocation(with: .init(lat: locationValue.latitude, lon: locationValue.longitude))
        
        locationManager.stopUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

}



