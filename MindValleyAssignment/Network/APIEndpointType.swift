

import Foundation

public enum APIEndpointType : Endpoint {
    case userList

    var path: String {
        switch self {
        case .userList:
            return "/raw/wgkJgazE"
        }
    }
    
    var base: String {
        switch self {
        case .userList:
            return "https://pastebin.com"
        }
    }

}
