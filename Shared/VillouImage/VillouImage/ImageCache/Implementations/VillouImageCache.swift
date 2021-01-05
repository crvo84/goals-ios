//
//  VillouImageCache.swift
//  VillouImage
//
//  Created by Carlos Villanueva Ousset on 29/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Kingfisher
import UIKit

public class VillouImageCache: ImageCache {

    private let manager = KingfisherManager.shared

    public init() {}

    public func getImage(with url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return completion(nil) }

        let resource = ImageResource(downloadURL: url)

        manager.retrieveImage(
            with: resource,
            options: [.scaleFactor(UIScreen.main.scale)],
            progressBlock: nil,
            downloadTaskUpdated: nil
        ) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(nil)
            }
        }
    }
}
