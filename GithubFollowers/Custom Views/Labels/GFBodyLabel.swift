//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-03.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: .body)
        
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        minimumScaleFactor = 0.75
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        lineBreakMode  = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
