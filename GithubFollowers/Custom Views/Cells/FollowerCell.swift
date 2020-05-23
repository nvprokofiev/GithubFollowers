//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-05.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func set(follower: Follower) {
        titleLabel.text = follower.login
        avatarImageView.downloadImage(urlString: follower.avatarUrl)
    }
}
