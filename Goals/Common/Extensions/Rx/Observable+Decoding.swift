//
//  Observable+Decoding.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

extension Single where Element == Data? {

    func decode<T: Decodable>(type: T.Type) -> Single<T> {
        self.asObservable()
            .map {
                guard let data = $0 else { return }
                try JSONDecoder().decode(type, from: $0)

            })
            .asSingle()
    }
}
