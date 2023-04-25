//
//  Date+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 25/04/2023.
//

import Foundation

extension Date {

    var month_date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyy"
        return formatter.string(from: self)
    }

    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy"
        return formatter.string(from: self)
    }
}
