import Foundation
import UIKit
import GoogleMaps

protocol GoogleMapsServiceDelegate {
    func setupMapView(view: UIView) -> GMSMapView
    func getMyCameraPosition(mapView: GMSMapView)
    func getZoomInValue(mapView: GMSMapView)
    func getZoomOutValue(mapView: GMSMapView)
}

final class GoogleMapsService: GoogleMapsServiceDelegate {
    func setupMapView(view: UIView) -> GMSMapView {
        var mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                              longitude:   0.0,
                                              zoom:         15)
        
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        return mapView
    }
    
    func getMyCameraPosition(mapView: GMSMapView)  {
        if let lat = mapView.myLocation?.coordinate.latitude,
           let lon = mapView.myLocation?.coordinate.longitude
        {
            let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lon, zoom: 15)
            
            mapView.camera = camera
        }
    }
    
    func getZoomInValue(mapView: GMSMapView) {
        let zoomInValue = mapView.camera.zoom + 1
        mapView.animate(toZoom: zoomInValue)
    }
    
    func getZoomOutValue(mapView: GMSMapView) {
        let zoomOutValue = mapView.camera.zoom - 1
        mapView.animate(toZoom: zoomOutValue)
    }
}
