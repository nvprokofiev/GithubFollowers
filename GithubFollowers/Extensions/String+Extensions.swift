//
//  String+Extensions.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-12.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDateFromISO8601()-> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
}
