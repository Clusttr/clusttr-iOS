//
//  Double+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Foundation

extension Double {
    func roundUpString(_ places: Int) -> String {
        String(format: "%.\(places)f", self)
    }

    var formattedAmount: String {
        let thousand = 1000.0
        let million = 1000000.0

        if self >= million {
            let formattedNumber = self / million
            return String(format: "%.1fm", formattedNumber)
        } else if self >= thousand {
            let formattedNumber = self / thousand
            return String(format: "%.1fk", formattedNumber)
        } else {
            return "\(self)"
        }
    }

    /// Rounds the double to decimal places value
    func rounded(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
