//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-09.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFItemInfoView: UIView {
    
    private let iconImageView = UIImageView()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)
    private let valueLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(count: Int, for type: ItemInfoType) {
        iconImageView.image = type.icon
        titleLabel.text = type.title
        valueLabel.text = String(count)
    }
    
    
    private func configure() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            valueLabel.heightAnchor.constraint(equalToConstant: 18),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }
}
