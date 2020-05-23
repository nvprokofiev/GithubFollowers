//
//  Endpoint.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-08.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case followers(username: String, page: Int)
    case user(username: String)

    private var baseUrl: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .followers(let username, let page):
            return baseUrl + "users/\(username)/followers?page=\(page)&per_page=100"
        case .user(let username):
            return baseUrl + "users/\(username)"
        }
    }
}
