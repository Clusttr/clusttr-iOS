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
            VStack(alignment: .trailing) {
                Button {
                    withAnimation(.spring()) {
                        showMenu.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.black)
                        .foregroundColor(Color._grey100)
                }
                .padding(.trailing)

                ProfileMenuView()
                    .frame(width: 180)
                    .padding(.top, 60)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 60)

            ProfileView(isActive: !showMenu, onClickMenu: toggleMenu)
                .cornerRadius(showMenu ? 20 : 0)
                .scaleEffect(showMenu ? 0.8 : 1)
                .offset(x: showMenu ? -180 : 0, y: showMenu ? 20 : 0)
                .rotationEffect(.degrees(showMenu ? 1 : 0))
                .rotation3DEffect(.degrees(showMenu ? 30 : 0), axis: (x: 0, y: 100, z: 0))
                .ignoresSafeArea()
                .shadow(color: Color.white.opacity(0.2), radius: 20, x: -10, y: 10)
        }
        .background(Color._grey800)
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
