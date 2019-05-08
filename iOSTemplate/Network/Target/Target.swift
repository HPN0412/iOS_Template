//
//  Target.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/6/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import Alamofire

protocol Target {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}
