//
//  String+Extensions.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 09/11/24.
//

import Foundation

extension String {
    var ageFromDob: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dob = dateFormatter.date(from: self) ?? Date()
        let age = Int(dob.timeIntervalSinceNow / 31_536_000) * -1
        return "\(age)"
    }
}
