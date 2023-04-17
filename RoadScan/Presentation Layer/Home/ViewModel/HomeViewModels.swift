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
    
    weak var delegate: OnUpdateDangerList?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
}

extension HomeViewModel {

    func fetchDangerList() {
        networkService.getDangerZone { [weak self] (result) in
            switch result{
            case .success(let danger):
                self?.dangerList = danger
                self?.updateViewData?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postDangerZone(param: DangerZoneModel) {
        self.notifyAboutDangerZone?()
        networkService.postDangerZone(param: param) { DangerResult in
//            self.dangerList.append(DangerResult)
//            self.updateViewData?()
            
        }
        
    }
    
}
