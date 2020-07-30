//
//  ImageCache.swift
//  VillouImage
//
//  Created by Carlos Villanueva Ousset on 29/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//


import UIKit

public protocol ImageCache {
    func getImage(with url: URL, completion: (UIImage?) -> Void)
}

extension ImageCache {

    func setImage(with url: URL?, to imageView: UIImageView, placeholder: UIImage? = nil) {
        if let placeholder = placeholder {
            imageView.image = placeholder
        }

        guard let url = url else { return }

        getImage(with: url) { img in
            imageView.image = img
        }
    }
}
