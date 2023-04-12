import Foundation

protocol HomeViewModelInput {
    var dangerList: DangerResult? { get set }
}

protocol HomeViewModelOutput {
    func fetchDangerList(detail: DangerZoneModel)
}

typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

protocol OnUpdateDangerList: AnyObject {
    func didUpdateDangerList()
}

final class HomeViewModel: HomeViewModelProtocol {
    var dangerList: DangerResult?
    
    weak var delegate: OnUpdateDangerList?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
}

extension HomeViewModel {
    func fetchDangerList(detail: DangerZoneModel) {
        networkService.postDangerZone(param: detail) { [weak self] (result) in
            guard let self = self else { return }
            
            self.dangerList = result
            self.delegate?.didUpdateDangerList()
        }
    }
}
