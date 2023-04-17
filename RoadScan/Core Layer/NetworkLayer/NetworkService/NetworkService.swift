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
    var latitude: Double
    var longitude: Double
    var danger_level: String
    var id_station: Int
}

enum getDangerZoneResult{
    case success(dangerZone: [DangerResult])
    case failure(error: Error)
}

//enum getDangerZoneResultFromPost{
//    case success(dangerZone: DangerResult)
//    case failure(error: Error)
//}

protocol NetworkServiceProtocol {
    func postDangerZone(param: DangerZoneModel, comp: @escaping((DangerResult)-> ()))
}

final class NetworkService: NetworkServiceProtocol {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
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
        
        

        AF.request("https://gentle-harbor-31655.herokuapp.com/api/cracks/ones",
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.default).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else {
                        print("nosir")
                        return
                    }
                    print("yessir")
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
    

    func getDangerZone(completion: @escaping(getDangerZoneResult) -> Void) {
        
        let url = URL(string: "https://gentle-harbor-31655.herokuapp.com/api/cracks/ones")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request) { [weak self] data, response, error in
            var result: getDangerZoneResult
            
            guard let strongSelf = self else { return }
            
            if let data = data, error == nil{
                guard let danger = try? strongSelf.decoder.decode( [DangerResult].self, from: data) else {
                    print("no")
                    print(data)
                    print(response as Any)
                    return }
               
                result = .success(dangerZone: danger)
            }else{
                result = .failure(error: error!)
                print("erorororor")
            }
            completion(result)
            
        }.resume()
    }
}




