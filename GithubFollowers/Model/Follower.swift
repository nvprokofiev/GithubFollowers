//
//  Follower.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-04.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
