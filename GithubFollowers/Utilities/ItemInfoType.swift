//
//  ItemInfoType.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-09.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
    
    var title: String {
        switch self {
        case .repos:
            return "Public repos"
        case .gists:
            return "Public gists"
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .repos:
            return UIImage(systemName: "folder")
        case .gists:
            return UIImage(systemName: "text.alignleft")
        case .followers:
            return UIImage(systemName: "person.2")
        case .following:
            return UIImage(systemName: "suit.heart")
        }
    }
}
