//
//  GFItemViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-11.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFItemViewController: UIViewController {

    private let stackView = UIStackView()
    let leftItem = GFItemInfoView()
    let rightItem = GFItemInfoView()
    let actionButton = GFButton()
            
    var user: User!
    var action: (()->Void)?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    private func configureBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20

        view.addSubview(stackView)
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 12)
        ])
    }

    private func configureStackView() {
        stackView.addArrangedSubview(leftItem)
        stackView.addArrangedSubview(rightItem)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 12
    }
    
    @objc private func didTapActionButton() {
        action?()
    }
}
