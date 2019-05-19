

import Foundation

class UserListClient: APIClient{
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }

    func getUserListResponse(from api: APIEndpointType, completion: @escaping (Result<Users, APIError>) -> Void) {
        fetch(with: api.request, decode: { json -> Users? in
            guard let userList = json as? Users else { return  nil }
            return userList
        }, completion: completion)
    }
}
