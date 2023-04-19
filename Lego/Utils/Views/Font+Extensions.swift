//
//  Font+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

extension Font {

    static func roboto(size: CGFloat) -> Font {
        .custom("Roboto-Regular.ttf", size: size)
    }

    static func robotoBold(size: CGFloat) -> Font {
        .custom("Roboto-Bold.ttf", size: size)
    }

    static func robotoMedium(size: CGFloat) -> Font {
        .custom("Roboto-Medium.ttf", size: size)
    }
}
