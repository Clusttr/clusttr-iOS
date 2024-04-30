//
//  WalletView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI
import Solana

struct WalletView: View {
    var isActive: Bool
    var onClickMenu: () -> Void
    @State var showAccountInfo = false
    @State var showSendScreen = false
    @State var showReceiveScreen = false
    @EnvironmentObject var accountManager: AccountManager
    @State private var navPath = NavigationPath()

    var account: HotAccount {
        accountManager.account
    }

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                HStack(alignment: .bottom, spacing:2) {
                    Text(accountManager.usdcBalance?.uiAmount ?? 0,
                         format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .fontWeight(.bold)

                    Button {
                        showAccountInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .popover(isPresented: $showAccountInfo) {
                        AccountInfoView()
                            .presentationDetents([.fraction(0.2)])
                    }
                }
                .foregroundColor(Color._grey100)

                AddressView(publicKey: account.publicKey)
            }

            HStack(spacing: 30) {
                Spacer()
                transactionButton(systemName: "square.and.arrow.down", title: "Top up") {
                    showReceiveScreen = true
                }
                transactionButton(systemName: "square.and.arrow.up", title: "Withdraw") {
                    navPath.append("Hello World")
                }
                transactionButton(systemName: "rectangle.portrait.and.arrow.right", title: "Send") {
                    showSendScreen = true
                }
                Spacer()
            }
            .padding(.top, 45)
            .popover(isPresented: $showSendScreen, content: {
                AddressPickerView(isShowing: $showSendScreen)
                    .environmentObject(accountManager)
            })
            .popover(isPresented: $showReceiveScreen) {
                ReceiveTokenView(isShowing: $showReceiveScreen)
            }

            VStack {
                HStack {
                    Text("Benefactors")
                        .font(.footnote)

                    Spacer()
                    Image(systemName: "qrcode.viewfinder")
                        .fontWeight(.bold)
                }
                .foregroundColor(._grey100)
                .padding(.horizontal)

                BenefactorRow()
            }
            .padding(.top, 45)

            Spacer()
        }
        .padding(.top, 90)
        .background(Color._background)
        .overlay {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Button(action: onClickMenu) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color._grey100)
                            .fontWeight(.black)
                    }
                    .padding()
                    .opacity(isActive ? 1 : 0)
                }
                Spacer()
            }
            .padding(.top, 44)
        }

    }

    func transactionButton(systemName: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(systemName: systemName)
                    .frame(width: 37, height: 37)
                    .background(Color._grey700)
                    .clipShape(Circle())
                Text(title)
                    .font(.caption2)
                    .fontWeight(.semibold)
            }
            .foregroundColor(._grey100)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(isActive: true, onClickMenu: {})
            .background(Color._background)
            .ignoresSafeArea()
            .environmentObject(AccountManager.mock())
    }
}
