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
    @AppStorage("activeProfileMenu") var selectedMenu: ProfileMenu = .profile
    
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

                ProfileMenuView(selectedMenu: $selectedMenu)
                    .onChange(of: selectedMenu) { _, _ in
                        withAnimation(.spring().delay(0.15)) {
                            showMenu = false
                        }
                    }
                    .frame(width: 180)
                    .padding(.top, 60)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 60)

            mainView
                .cornerRadius(showMenu ? 20 : 0)
                .scaleEffect(showMenu ? 0.8 : 1)
                .offset(x: showMenu ? -180 : 0, y: showMenu ? 20 : 0)
                .rotation3DEffect(.degrees(showMenu ? 30 : 0), axis: (x: 0, y: 100, z: 0))
                .ignoresSafeArea()
                .shadow(color: Color.white.opacity(0.2), radius: 20, x: -10, y: 10)
        }
        .background(Color._grey800)
    }

    var profileView: ProfileView {
        ProfileView(isActive: !showMenu, onClickMenu: toggleMenu)
    }

    var walletView: WalletView {
        WalletView(isActive: !showMenu, onClickMenu: toggleMenu)
    }

    var bankAccountsView: BankAccountsView {
        BankAccountsView(onClickMenu: toggleMenu)
    }

    var verifyIdentityView: VerifyIdentityView {
        VerifyIdentityView(onClickMenu: toggleMenu)
    }

    var referralView: ReferralView {
        ReferralView(onClickMenu: toggleMenu)
    }

    var supportView: SupportView {
        SupportView(onClickMenu: toggleMenu)
    }

    var securityView: SecurityView {
        SecurityView(onClickMenu: toggleMenu)
    }

    var mainView: some View {
        ZStack {
            profileView
                .opacity(opacity(menu: .profile))
            walletView
                .opacity(opacity(menu: .wallet))
            verifyIdentityView
                .opacity(opacity(menu: .verifyIdentity))
            bankAccountsView
                .opacity(opacity(menu: .banks))
            securityView
                .opacity(opacity(menu: .security))
            referralView
                .opacity(opacity(menu: .referralAndEarn))
            supportView
                .opacity(opacity(menu: .support))
        }
    }

    func opacity(menu: ProfileMenu) -> Double {
        menu == selectedMenu ? 1 : 0
    }

    func toggleMenu() {
        withAnimation {
            showMenu.toggle()
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(AppState())
            .environmentObject(AccountManager.create())
    }
}
