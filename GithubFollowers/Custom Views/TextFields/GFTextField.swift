//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-03.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with placeholder: String) {
        super.init(frame: .zero)
        configure()
        self.placeholder = placeholder
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        autocorrectionType = .no
        minimumFontSize = 12
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        
        backgroundColor = .tertiarySystemBackground
        returnKeyType = .go
    }
}
