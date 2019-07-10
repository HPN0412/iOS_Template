//
//  ResponseObject.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/8/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import ObjectMapper

final class ResponseObject: Mappable {
    var statusCode: Int?
    var message: String?
    var data: Any?
    var debug: Any?

    init() {}

    required init?(map: Map) { }

    func mapping(map: Map) {
        statusCode <- map["status_code"]
        message <- map["messages"]
        data <- map["data"]
        debug <- map["debug"]
    }
}
