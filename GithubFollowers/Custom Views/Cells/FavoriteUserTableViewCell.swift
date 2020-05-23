//
//  FavoriteUserTableViewCell.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-18.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class FavoriteUserTableViewCell: UITableViewCell {
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        
        accessoryType = .disclosureIndicator
                
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor)
        ])
    }
    
    func set(user: Follower) {
        avatarImageView.downloadImage(urlString: user.avatarUrl)
        titleLabel.text = user.login
    }
}
