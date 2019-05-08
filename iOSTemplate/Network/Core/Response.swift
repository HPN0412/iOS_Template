//
//  Response.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/8/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {
    
    // MARK: - Handle response result
    /// Handler response result, check status code or data format
    ///
    /// - parameter response:  Data response return from server
    /// - parameter completion:  The closure caller when complete handler
    func handlerResult(_ response: DataResponse<ResponseObject>, completion: ApiCompletion) {

        guard let _ = response.response?.statusCode else {
            completion(.failure(NSError.noResponse))
            return
        }
        // TODO: - Handle every thing
    }
}
