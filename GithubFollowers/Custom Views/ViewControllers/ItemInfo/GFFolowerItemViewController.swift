//
//  GFFolowerItemViewController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-11.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFFolowerItemViewController: GFItemViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        leftItem.set(count: user.followers, for: .followers)
        rightItem.set(count: user.following, for: .following)

        actionButton.setTitle("Get Followers", for: .normal)
        actionButton.backgroundColor = .systemGreen
    }
}
