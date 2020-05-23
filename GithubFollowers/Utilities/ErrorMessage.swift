//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-04.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
    case invalidUsername
    case unableToComplete
    case invalidResponse
    case invalidData
    case unableToEncode
    case alreadySaved
    
    var message: String {
        switch self {

        case .invalidUsername:
            return "Username is not exist. Please try another one"
        case .unableToComplete:
            return "Unable to complete the request. PLease check the internet connection"
        case .invalidResponse:
            return "Invalid response from the server"
        case .invalidData:
            return "The data received from the server was not valid. Please try again"
        case .unableToEncode:
            return "Unable to save to favorites"
        case .alreadySaved:
            return "The user is already in Favorites"
        }
    }
}
