//
//  Font+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

extension Font {

    static func roboto(size: CGFloat) -> Font {
        .custom("Roboto-Regular", size: size)
    }

    static func robotoBold(size: CGFloat) -> Font {
        .custom("Roboto-Bold", size: size)
    }

    static func robotoMedium(size: CGFloat) -> Font {
        .custom("Roboto-Medium", size: size)
    }

    static func pacifico(size: CGFloat) -> Font {
        .custom("Pacifico-Regular", size: size)
    }
}
