//
//  Image+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 13/04/2023.
//

import SwiftUI

extension Image {
    static var ape: Image {
        Image("Ape-profile")
    }

    static var banner: Image {
        Image("Banner")
    }

    static var wallpaper: Image {
        Image("wallpaper")
    }

    //icons
    static var home: Image {
        Image("Home")
    }

    static var profile: Image {
        Image("Profile")
    }

    static var helmet: Image {
        Image(systemName: "archivebox")//Image("Helmet")
    }

    static var ellipseMenu: Image {
        Image("EllipseMenu")
    }

    static var search: Image {
        Image(systemName: "magnifyingglass")
    }
}
