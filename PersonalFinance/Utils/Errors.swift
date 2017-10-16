//
//  Errors.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
    case generalError(reason: String)
    case validationError(reason: [String: Any])
}
