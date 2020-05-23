//
//  CacheManager.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-05.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}

    func save(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(for key: String)-> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
