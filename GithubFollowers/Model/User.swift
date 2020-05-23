//
//  User.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-04.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct User: Decodable {
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var location: String?
    var name: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: String
}
