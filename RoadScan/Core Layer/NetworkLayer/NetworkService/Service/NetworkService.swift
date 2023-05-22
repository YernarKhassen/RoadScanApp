import Alamofire
import Foundation

protocol NetworkService{
    func postDangerZone(param: DangerZoneInputModel, comp: @escaping((Result<DangerResult, Error>)-> ()))
    func getDangerZone(completion: @escaping(Result<[DangerResult], Error>) -> Void)
}

final class NetworkServiceImpl {
    
}

extension NetworkServiceImpl: NetworkService {
    func postDangerZone(param: DangerZoneInputModel, comp: @escaping((Result<DangerResult, Error>)-> ())) {
        guard let lat = param.latitude,
              let lon = param.longitude,
              let dangerLvl = param.danger_level else {
            return
        }
        
        let param = [
            "city": param.city,
            "latitude": lat,
            "longitude": lon,
            "danger_level": dangerLvl
        ] as [String : Any]
        
        AF.request(NetworkConstants.baseURL,
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.default).response { response in
            debugPrint(response)
            
            switch response.result {
            case let .success(data):
                do {
                    guard let data = data else {
                        return
                    }
                    
                    let result = try JSONDecoder().decode(DangerResult.self, from: data)
                    comp(.success(result))
                } catch {
                    comp(.failure(error))
                }
            case let .failure(error):
                comp(.failure(error))
            }
        }
    }

    func getDangerZone(completion: @escaping(Result<[DangerResult], Error>) -> Void) {
        AF.request(NetworkConstants.baseURL,
                   method: .get,
                   encoding: JSONEncoding.default).response { result in
            debugPrint(result)
            
            switch result.result {
            case let .success(data):
                do {
                    guard let data = data else {
                        return
                    }
                    
                    let result = try JSONDecoder().decode([DangerResult].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
