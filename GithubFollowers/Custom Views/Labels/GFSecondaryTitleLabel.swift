//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-08.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: GFTitleLabel  {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        minimumScaleFactor = 0.9
        adjustsFontSizeToFitWidth = true
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
}
