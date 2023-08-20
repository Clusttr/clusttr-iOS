//
//  menu.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 31/07/2023.
//

import Foundation
import SwiftUI

protocol Menu {
    var title: String { get }
    var icon: Image { get }
}

struct SingleMenu: Menu {
    let title: String
    let icon: Image

    init(title: String, icon: Image) {
        self.title = title
        self.icon = icon
    }
}
