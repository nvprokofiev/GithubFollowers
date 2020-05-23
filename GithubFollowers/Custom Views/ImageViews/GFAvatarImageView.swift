//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-05.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    private let placeholderImage = #imageLiteral(resourceName: "avatar-placeholder")
    private let cache = ImageCacheManager.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }

    func downloadImage(urlString: String) {
        if let cachedImage = cache.image(for: urlString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let downloaded = UIImage(data: data) else { return }
            self?.cache.save(image: downloaded, for: urlString)
            
            DispatchQueue.main.async {
                self?.image = downloaded
            }
        }.resume()
    }
}
