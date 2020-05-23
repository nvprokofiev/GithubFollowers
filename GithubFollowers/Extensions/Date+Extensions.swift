//
//  Date+Extensions.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-12.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

extension Date {
    
    func toMMMyyyy()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
}
