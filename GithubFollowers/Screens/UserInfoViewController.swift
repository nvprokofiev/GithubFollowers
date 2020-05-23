//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-07.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoViewControllerDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: UIViewController {
    
    private let headerView = UIView()
    private let itemViewFirst = UIView()
    private let itemViewSecond = UIView()
    private let dateLabel = GFSecondaryTitleLabel(fontSize: 16)
    
    private var username: String
    private var user: User?
    
    weak var delegate: UserInfoViewControllerDelegate?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUser()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        view.addSubview(headerView)
        view.addSubview(itemViewFirst)
        view.addSubview(itemViewSecond)
        view.addSubview(dateLabel)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewFirst.translatesAutoresizingMaskIntoConstraints = false
        itemViewSecond.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewFirst.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewFirst.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewSecond.topAnchor.constraint(equalTo: itemViewFirst.bottomAnchor, constant: padding),
            itemViewSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewSecond.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewSecond.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func getUser() {
        NetworkManager.shared.getUser(username: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.main.async { self.setupUI(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went bad", message: error.message, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupUI(with user: User) {
        
        self.addChild(vc: GFUserInfoViewController(user: user), to: self.headerView)
        
        let reposVC = GFRepoItemViewController(user: user)
        let followersVC = GFFolowerItemViewController(user: user)
        
        reposVC.action = didTapGithubButton
        followersVC.action = didRequestFollowers
        
        self.addChild(vc: reposVC, to: self.itemViewFirst)
        self.addChild(vc: followersVC, to: self.itemViewSecond)
        
        if let date = user.createdAt.convertToDateFromISO8601() {
            self.dateLabel.text = "GitHub since " + date.toMMMyyyy()
        } else {
            self.dateLabel.removeFromSuperview()
        }
    }

    private func addChild(vc: UIViewController, to container: UIView) {
        addChild(vc)
        container.addSubview(vc.view)
        vc.view.frame = container.bounds
        vc.didMove(toParent: self)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func didTapGithubButton() {
        guard let user = user, let url = URL(string: user.htmlUrl) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    private func didRequestFollowers() {
        guard let user = user, user.followers > 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user doesn't have any followers.", buttonTitle: "Ok")
            return
        }
        delegate?.didRequestFollowers(for: username)
        dismissViewController()
    }
}
