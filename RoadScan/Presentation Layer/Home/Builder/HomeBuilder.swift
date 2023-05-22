//
//  HomeViewModel.swift
//  RoadScan
//
//  Created by Адема Сапакова on 06.04.2023.
//

import CoreLocation
import GoogleMaps

private protocol HomeBuilderInputProtocol {
    var stackOfPins: [PinViewModel] { get set }
}

protocol HomeBuilderOutputProtocol {
    func getStackOfPins() -> [PinViewModel]
    func makePathCoordinates() -> [CLLocationCoordinate2D]
}

final class HomeBuilder: HomeBuilderInputProtocol, HomeBuilderOutputProtocol {
    fileprivate var stackOfPins: [PinViewModel] = []
    
    func getStackOfPins() -> [PinViewModel] {
        return stackOfPins
    }
    
    func addPinCoordinate(lat : Double, lon : Double, mapview: GMSMapView, dangerLevel: DangerLvlState) {
        stackOfPins.append(.init(latitude: lat , longitude: lon, nameOfLocation: "unknown"))
        setPins(with: mapview, with: dangerLevel)
    }
    
    // MARK: - Adema ozegertedy
    func makePathCoordinates() -> [CLLocationCoordinate2D] {
        var coordinate: [CLLocationCoordinate2D] = []
        getStackOfPins().forEach {
            coordinate.append(.init(latitude: $0.latitude, longitude: $0.longitude))
        }
        
        
        return coordinate
    }
    
    // MARK: - для будущее
//    func drawCoordinates(with mapView: GMSMapView) {
//        let path = GMSMutablePath()
//        makePathCoordinates().forEach { path.add($0) }
//        let polyline = createPolyline(from: path, with: .red, and: 5)
//        polyline.map = mapView
//    }
    
    func setPins(with mapView: GMSMapView, with state: DangerLvlState) {
        for location in stackOfPins {
            switch state {
            case .low:
                addMarker(to: mapView,
                          at: location.latitude,
                          and: location.longitude,
                          with: location.nameOfLocation,
                          dangerImageName: "greenCircle")
            case .medium:
                addMarker(to: mapView,
                          at: location.latitude,
                          and: location.longitude,
                          with: location.nameOfLocation,
                          dangerImageName: "brownCircle")
            case .hight:
                addMarker(to: mapView,
                          at: location.latitude,
                          and: location.longitude,
                          with: location.nameOfLocation,
                          dangerImageName: "redCircle")
            }
        }
    }
    
    func buildDangerZoneInputModel(model: DangerZoneInputModel) -> DangerZoneInputModel {
        return model
    }
    
    private func createPolyline(from path: GMSMutablePath, with strokeColor: UIColor, and strokeWidth: CGFloat) -> GMSPolyline {
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = strokeColor
        polyline.strokeWidth = strokeWidth
        return polyline
    }
}

// MARK: - add marker for adding pins for map
extension HomeBuilder {
    private func addMarker(to mapView: GMSMapView,
                           at latitude: CLLocationDegrees,
                           and longitude: CLLocationDegrees,
                           with title: String,
                           dangerImageName: String) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        let imageView = UIImageView(image: UIImage(named: dangerImageName))
                imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        marker.iconView = imageView
        marker.map = mapView
    }
}
