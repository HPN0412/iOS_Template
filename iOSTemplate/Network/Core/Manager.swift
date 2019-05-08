//
//  APIManager.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/8/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias ApiCompletion = (Result<Any>) -> Void

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }

    var networkAvailable: Bool {
        switch NetworkReachabilityManager.shared.networkReachabilityStatus {
        case .unknown, .notReachable: return false
        case .reachable: return true
        }
    }

    var uploadRequest: Request?
}

extension NetworkReachabilityManager {
    static var shared: NetworkReachabilityManager {
        guard let manager = NetworkReachabilityManager() else {
            fatalError("Can't init network manager")
        }
        return manager
    }
}
