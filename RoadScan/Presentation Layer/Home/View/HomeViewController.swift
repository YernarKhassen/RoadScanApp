import UIKit
import GoogleMaps
import SnapKit
import CoreMotion


final class HomeViewController: UIViewController {
    
    private let coreMotionService = CoreMotionService()
    private let googleMapsService = GoogleMapsService()
    private let homeBuilder = HomeBuilder()
    private let viewModel = HomeViewModel()
    var mapView = GMSMapView()
    
    var testcount = 0
    
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
    
    private lazy var segmentedControlView: UIView = {
        let viewToSC = UIView()
        viewToSC.addSubview(segmentedControl)
        return viewToSC
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl()
        segControl = UISegmentedControl(items: ["Точки", "Цветовые схемы"])
        segControl.removeBorder()
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainBlue], for: .selected)
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.459,
                                                                                           green: 0.459,
                                                                                           blue: 0.459,
                                                                                           alpha: 1)], for: .normal)
        segControl.selectedSegmentIndex = 0
        return segControl
    }()
    
    override func loadView() {
        super.loadView()
        coreMotionService.startMotion()
        fetchDangerList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        binding()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        setUpGoogleMaps()
        initialize()
        makeConstraints()
        
        coreMotionService.carIsDrivingStart = { [weak self] dangerLevel in
            guard let self = self,
                  let latitude = self.mapView.myLocation?.coordinate.latitude,
                  let longitude = self.mapView.myLocation?.coordinate.longitude else {
                return
            }
            
            self.callLocalNotification(descption: "Неровная поверхность", time: 1.5)
            
            self.viewModel.postDangerZone(param:
                                            self.homeBuilder.buildDangerZoneInputModel(model: .init(city: "Almaty",
                                                                                               latitude: latitude,
                                                                                               longitude: longitude,
                                                                                                         danger_level: dangerLevel.rawValue)))
            
            self.homeBuilder.addPinCoordinate(lat: latitude,
                                              lon: longitude,
                                              mapview: self.mapView,
                                              dangerLevel: dangerLevel)
            
            
            // MARK: - Для будущее
            
            self.viewModel.checkingForPinCount(callback: {
                
                
            })
                
                // MARK: - Для будущее если нужно:)
                
//                let camera = GMSCameraPosition.camera(withLatitude: self?.mapView.myLocation?.coordinate.latitude ?? 0.0,
//                                                      longitude:   self?.mapView.myLocation?.coordinate.longitude ?? 0.0,
//                                                      zoom:         15.0)
//
//
//                self?.mapView.animate(to: camera)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewLayer()
    }
    
    private func configureViewLayer() {
        segmentedControlView.layer.masksToBounds = false
        segmentedControlView.layer.cornerRadius = 16
        segmentedControlView.layer.shadowRadius = 4
        segmentedControlView.layer.shadowOpacity = 1
        segmentedControlView.layer.shadowColor = UIColor(red: 0,
                                                         green: 0,
                                                         blue: 0,
                                                         alpha:0.15).cgColor
    }
    
    private func setUpGoogleMaps(){
        mapView = googleMapsService.setupMapView(view: view)
        view.addSubview(mapView)
    }
    
    private func makeConstraints() {
        segmentedControlView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width - 30)
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
        
        segmentedControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func initialize() {
        [segmentedControlView, plusZoom, minusZoom, myLocation].forEach {
            view.addSubview($0)
        }
    }
    
    @objc func showMyLocation() {
        googleMapsService.getMyCameraPosition(mapView: mapView)
    }
    
    @objc func onTapPlus() {
        googleMapsService.getZoomInValue(mapView: mapView)
    }
    
    @objc func onTapMinus() {
        googleMapsService.getZoomOutValue(mapView: mapView)
    }
}

extension HomeViewController {
    func binding() {
        viewModel.updateViewData = { [weak self] in
            DispatchQueue.main.async {
                guard let mapView = self?.mapView,
                      let list = self?.viewModel.dangerList,
                      let latitude = mapView.myLocation?.coordinate.latitude,
                      let longitude = mapView.myLocation?.coordinate.longitude else { return }
                
                for element in list {
                    if let dangerLvl = DangerLvlState.init(rawValue: element.danger_level) {
                        self?.homeBuilder.addPinCoordinate(lat: latitude, lon: longitude, mapview: mapView, dangerLevel: dangerLvl)
                    }
                }
            }
        }
    }
    
    func fetchDangerList() {
        viewModel.fetchDangerList()
    }
}
