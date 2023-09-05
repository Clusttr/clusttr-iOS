//
//  TestDTO.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import Foundation

struct TestDTO: Codable, CustomDebugStringConvertible {
    let message: String

    var debugDescription: String {
        message
    }
}
