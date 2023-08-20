//
//  MenuView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 02/07/2023.
//

import SwiftUI

struct ProfileMenuView: View {
    let menuList: [ProfileMenu] = ProfileMenu.allCases
    @Binding var selectedMenu: ProfileMenu
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            ForEach(menuList) { menu in
                MenuItemView(menu: menu, isSelected: menu == selectedMenu) {
                    withAnimation {
                        selectedMenu = menu
                    }
                }
            }

            Spacer()
            MenuItemView(menu: SingleMenu(title: "Sign Out", icon: Image(systemName: "power")),
                         isSelected: false,
                         onClick: signOut)
        }
        .padding(.bottom, 120)
    }

    func signOut() {
        withAnimation {
            appState.loginState = .loggedOut
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView(selectedMenu: .constant(.profile))
            .background(Color._background)
            .environmentObject(AppState())
    }
}
