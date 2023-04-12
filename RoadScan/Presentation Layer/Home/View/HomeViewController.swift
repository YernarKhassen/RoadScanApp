import UIKit
import GoogleMaps
import SnapKit
import CoreMotion


final class HomeViewController: UIViewController, AlertProtocol {
    private let locationService = LocationService()
    private let coreMotionService = CoreMotionService()
    private let googleMapsService = GoogleMapsService()
    private let locationManager = CLLocationManager()

    
    var mapView = GMSMapView()
    
    /// need delete
    let items = ["Точки",
                 "Цветовые схемы"]
    
    private lazy var plusZoom: UIButton = {
        let plusZoom = UIButton()
        plusZoom.setBackgroundImage(UIImage(named: "Plus"), for: .normal)
        plusZoom.addTarget(self, action: #selector(onTapPlus), for: .touchUpInside)
        
        return plusZoom
    }()
    
    private lazy var minusZoom: UIButton = {
        let minusZoom = UIButton()
        minusZoom.setBackgroundImage(UIImage(named: "Minus"), for: .normal)
        minusZoom.addTarget(self, action: #selector(onTapMinus), for: .touchUpInside)
        return minusZoom
    }()
    
    private lazy var myLocation: UIButton = {
        let myLocation = UIButton()
        myLocation.setBackgroundImage(UIImage(named: "myLocation"), for: .normal)
        myLocation.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        
        return myLocation
    }()
    
    private lazy var viewToSC: UIView = {
        let viewToSC = UIView()
        viewToSC.addSubview(segControl)
        
        return viewToSC
    }()
    
    private lazy var segControl: UISegmentedControl = {
        var segControl = UISegmentedControl()
        segControl = UISegmentedControl(items: items)
        segControl.removeBorder()
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainBlue], for: .selected)
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.459,
                                                                                           green: 0.459,
                                                                                           blue: 0.459,
                                                                                           alpha: 1)],
                                                                                           for: .normal)
        segControl.selectedSegmentIndex = 0
        return segControl
    }()
    
    override func loadView() {
        super.loadView()
        locationService.delegate = self
        locationService.delegateAlert = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
       
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                              longitude:   0.0,
                                              zoom:         0)
        mapView = GMSMapView.map(withFrame: view.frame,
                                     camera: camera)
        mapView.camera = camera
        
        self.view.addSubview(mapView)
        setup()
        coreMotionService.speedDetecting()
    }
    
    private func setup() {
        setUpGoogleMaps()
        initialize()
        makeConstraints()
        coreMotionService.startMotion()
        coreMotionService.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewLayer()
    }
    
    // нужно написать extetion
    private func configureViewLayer() {
        viewToSC.layer.masksToBounds = false
        viewToSC.layer.cornerRadius = 16
        viewToSC.layer.shadowRadius = 4
        viewToSC.layer.shadowOpacity = 1
        viewToSC.layer.shadowColor = UIColor(red: 0,
                                             green: 0,
                                             blue: 0,
                                             alpha:0.15).cgColor
    }
    
    // нужно удалить метод или обьекти если не юзается
    private func setUpGoogleMaps(){
        mapView = googleMapsService.setupMapView(view: view)
        view.addSubview(mapView)
    }
    // constraint не должны быть много чем 54
    private func makeConstraints() {
        viewToSC.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(46)
        }
        
        plusZoom.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalToSuperview().inset(343)
            make.right.equalToSuperview().inset(12)
        }
        
        minusZoom.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalTo(plusZoom.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(12)
        }
        
        myLocation.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalTo(minusZoom.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(12)
        }
        
        segControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // создать extetion для view.addArangedSubviews []
    private func initialize() {
        [viewToSC, plusZoom, minusZoom, myLocation].forEach {
            view.addSubview($0)
        }
    }
    
    func grantPermission() {
        let alert = UIAlertController(title: "Доступ к местоположению запрещен", message: "Пожалуйста перейдите в настройки своего телефона, чтобы предоставить разрешение на доступ к вашему местоположению", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        { (action) in
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showMyLocation() {
        print("my location")
        googleMapsService.getMyCameraPosition(mapView: mapView)
    }
    
    @objc func onTapPlus() {
        googleMapsService.getZoomInValue(mapView: mapView)
    }
    
    @objc func onTapMinus() {
        googleMapsService.getZoomOutValue(mapView: mapView)
    }
}

// MARK: - LocationService Delegate
extension HomeViewController: CoreMotionServiceDelegate, LocationServiceProtocol  {
    func getCurrentLocation(with location: CurrentLocationModel) {
        let camera = GMSCameraPosition.camera(withLatitude: location.lat,
                                              longitude:   location.lon,
                                              zoom:         15.0)
        
        mapView.animate(to: camera)
    }
    
    func getDetectableSpeedState(state: DetectableSpeed, rate: Double) {
        if state == .carIsDriving {
            print("тут кочка")
        } else {
            print("тут ne кочка")
        }
      
    }
    
    func getCoordinateMotionDevice(with data: CoreMotionViewModel) {
        print("x ---------->", data.xPosition)
        print("y ---------->", data.yPosition)
        print("z----------->", data.zPosition)
    }
}

