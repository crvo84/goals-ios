//
//  SecureStoreError.swift
//  VillouSecureStore
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum SecureStoreError: Error {
    case encodingError(Error?)
    case decodingError(Error?)
    case unknown(Error?)
}
