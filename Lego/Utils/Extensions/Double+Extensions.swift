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
}
