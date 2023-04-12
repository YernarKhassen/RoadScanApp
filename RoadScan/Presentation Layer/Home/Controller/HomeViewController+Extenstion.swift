import GoogleMaps

// MARK: - CoreMotionService Delegate
extension HomeViewController: CoreMotionServiceDelegate {
    func getCoordinateMotionDevice(with data: CoreMotionViewModel) {
        print("x ---------->", data.xPosition)
        print("y ---------->", data.yPosition)
        print("z----------->", data.zPosition)
    }
}

// MARK: - LocationService Delegate
extension HomeViewController: LocationServiceProtocol {
    func getCurrentLocation(with location: CurrentLocationModel) {
        let camera = GMSCameraPosition.camera(withLatitude: location.lat,
                                              longitude:   location.lon,
                                              zoom:         15.0)
        
        mapView.animate(to: camera)
    }
}
