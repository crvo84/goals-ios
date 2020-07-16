//
//  SecureStoreError.swift
//  VillouSecureStore
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum SecureStoreError: Error {
    case encoding(Error?)
    case decoding(Error?)
    case storing(Error?)
    case retrieving(Error?)
    case deleting(Error?)
    case unknown(Error?)
}
