//
//  NetworkError.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/8/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation

extension NSError {
    static let serviceError = NSError(status: .serviceError)
    static let noResponse = NSError(status: .noResponse)
}
