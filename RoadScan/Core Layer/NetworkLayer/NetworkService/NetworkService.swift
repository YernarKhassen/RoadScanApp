import Alamofire
import Foundation

struct DangerZoneModel {
    var city: String
    var latitude: Double?
    var longitude: Double?
    var danger_level: String?
}

struct DangerResult: Codable {
    var city: String
    var latitude: Double?
    var longitude: Double?
    var danger_level: String?
    var id_station: Int
}


protocol NetworkServiceProtocol {
    func postDangerZone(param: DangerZoneModel, comp: @escaping((DangerResult)-> ()))
}

final class NetworkService: NetworkServiceProtocol {
    
    func postDangerZone(param: DangerZoneModel, comp: @escaping ((DangerResult) -> ())) {
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
        
        AF.request("https://stormy-badlands-01638.herokuapp.com/api/cracks/",
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.default).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else {
                        return
                    }
                    
                    let result = try JSONDecoder().decode(DangerResult.self, from: data)
                    comp(result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
               debugPrint(error)
            }
        }
    }
}




