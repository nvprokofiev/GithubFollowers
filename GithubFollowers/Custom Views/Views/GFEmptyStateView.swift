//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-06.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "empty-state-logo"))
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        titleLabel.text = title
    }
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        titleLabel.text = title
        configure()
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(logoImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.numberOfLines = 0
        titleLabel.textColor = .secondaryLabel
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 80),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: frame.width / 1.7),
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
        ])
        
    }
}
