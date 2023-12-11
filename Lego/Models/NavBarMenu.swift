//
//  NavBarMenu.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Foundation

enum NavBarMenu: String, Identifiable, CaseIterable {
    case home
//    case search
//    case plus
//    case discovery
    case profile
//    case developer

    var id: String {
        self.rawValue
    }

    var index: Int {
        switch self {
        case .home:
            return 0
//        case .search:
//            return 1
//        case .plus:
//            return 2
//        case .discovery:
//            return 3
        case .profile:
            return 1
//        case .developer:
//            return 2
        }
    }
}
