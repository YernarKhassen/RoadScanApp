//
//  HomeViewModel.swift
//  RoadScan
//
//  Created by Tanirbergen Kaldibai on 08.04.2023.
//

import Foundation

protocol HomeViewModelInput {
    var dangerList: [DangerResult] { get set }
}

protocol HomeViewModelOutput {
    func fetchDangerList()
}

typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

protocol OnUpdateDangerList: AnyObject {
    func didUpdateDangerList()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var updateViewData: (() -> ())?
    
    var notifyAboutDangerZone: (() -> ())?
    
    var dangerList = [DangerResult]()
    
    var countOfPins = 0
    
    weak var delegate: OnUpdateDangerList?
    
    private let networkService: NetworkService
    
    // MARK: - Dispatch objects
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
}

extension HomeViewModel {

    func fetchDangerList() {
        networkService.getDangerZone { [weak self] (response) in
            switch response {
            case let .success(result):
                self?.dangerList = result
                self?.updateViewData?()
            case .failure(_):
                break
            }
        }
    }
    
    func checkingForPinCount(callback: @escaping(() -> Void)) {
        countOfPins += 1
        
        if countOfPins < 2 {
            return
        }
        
        countOfPins = 0
        callback()
    }
    
    func postDangerZone(param: DangerZoneInputModel) {
        networkService.postDangerZone(param: param) { model in
        
        }
    }
}
