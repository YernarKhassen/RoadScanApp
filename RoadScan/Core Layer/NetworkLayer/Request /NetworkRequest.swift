import Alamofire

protocol NetworkRequest {
    func request(endPoint: String, method: HttpMethods, parametrs: [String: Any]) -> Alamofire.AFResult<Any>
}

extension NetworkRequest {
    func request(endPoint: String, method: HttpMethods, parametrs: [String: Any]) {
        print("sdsd")
    }
}

