//
//  AppState.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/04/2023.
//

import Foundation

class AppState: ObservableObject {
    @Published var isNavBarHidden = false
    @Published var loginState: LoginStatus = .onBoarding
}
