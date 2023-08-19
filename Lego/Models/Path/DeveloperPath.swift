//
//  DeveloperPath.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/08/2023.
//

import Foundation

enum DeveloperPath {
    case createNFT
}

import SwiftUI
extension DeveloperPath: View {
    var body: some View {
        switch self {
        case .createNFT:
            CreateNFTView()
        }
    }
}
