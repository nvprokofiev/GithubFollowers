//
//  GFRepoItemViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-11.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFRepoItemViewController: GFItemViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        leftItem.set(count: user.publicRepos, for: .repos)
        rightItem.set(count: user.publicGists, for: .gists)

        actionButton.setTitle("GitHub Profile", for: .normal)
        actionButton.backgroundColor = .systemPurple
    }

}
