//
//  ProfileMenu.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/07/2023.
//

import Foundation
import SwiftUI

enum ProfileMenu: String, Menu, CaseIterable, Identifiable {
    case profile
    case wallet
    case verifyIdentity
    case banks
    case security
    case referralAndEarn
    case support

    var id: Self { self }

    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .wallet:
            return "wallet"
        case .verifyIdentity:
            return "Verify Identity"
        case .banks:
            return "Banks"
        case .security:
            return "Security"
        case .referralAndEarn:
            return "Referral & Earn"
        case .support:
            return "Support"
        }
    }
}

//icon
extension ProfileMenu {
    var icon: Image {
        switch self {
        case .profile:
            return Image(systemName: "person.fill")
        case .wallet:
            return Image(systemName: "creditcard.fill")
        case .verifyIdentity:
            return Image(systemName: "person.fill.checkmark")
        case .banks:
            return Image(systemName: "building.columns")
        case .security:
            return Image(systemName: "touchid")
        case .referralAndEarn:
            return Image(systemName: "dollarsign.circle")
        case .support:
            return Image(systemName: "person.line.dotted.person")
        }
    }
}
