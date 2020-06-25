//
//  NetworkingManager.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkingManager {
    func execute(request: ApiRequest) -> Single<Data?>
}
