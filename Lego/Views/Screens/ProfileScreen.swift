//
//  ProfileScreen.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/07/2023.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var appState: AppState
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            ProfileView(onClickMenu: toggleMenu)
                .cornerRadius(showMenu ? 20 : 0)
                .scaleEffect(showMenu ? 0.85 : 1)
                .offset(x: showMenu ? -150 : 0, y: showMenu ? 30 : 0)
                .rotationEffect(.degrees(showMenu ? 4 : 0))
                .ignoresSafeArea()
                .shadow(color: Color.white.opacity(0.2), radius: 20, x: -10, y: 10)
        }
        .background(Color._gray800)
    }

    func toggleMenu() {
        withAnimation(.spring()) {
            showMenu.toggle()
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(AppState())
    }
}
