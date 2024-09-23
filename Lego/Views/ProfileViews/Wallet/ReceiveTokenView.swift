//
//  ReceiveTokenView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/03/2024.
//

import AlertToast
import SwiftUI

struct ReceiveTokenView: View {
    @Binding var isShowing: Bool
    @State var isLoading: Bool = false
    @State var showingCopyToast = false
    @State var showingAirdropToast = false
    @State var error: ClusttrError?
    @EnvironmentObject var accountManager: AccountManager
    var userService: IUserService = UserService()

    var body: some View {
        VStack {
            HStack {
                Button {
                    isShowing = false
                } label: {
                    Image(systemName: "xmark")
                }
                Spacer()
                Text("Send USD to")
                Spacer()
            }
            .foregroundColor(Color._grey100)
            .fontWeight(.medium)
            .padding(.horizontal, 16)
            .padding(.top, 24)

            Spacer()

            VStack {
                Image(uiImage: accountManager.account.publicKey.generateQRCode())
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(8)
                AddressView(account: accountManager.account)
                    .padding(.top, 32)
            }
            .offset(y: -50)

            Spacer()

            Button {
                isLoading = true
                Task {
                    do {
                        _ = try await userService.airdrop()
                        DispatchQueue.main.async {
                            showingAirdropToast = true
                            isLoading = false
                        }
                    } catch {
                        self.error = ClusttrError.failedTransaction
                    }
                }
            } label: {
                Text("Click to request $100 airdrop")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(Color._grey2)
                    .padding()
                    .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                    .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 0)
                    .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 0)
            }

            HStack(spacing: 24) {
                ActionButton(title: "COPY") {
                    UIPasteboard.general.string = accountManager.account.publicKey.base58EncodedString
                    showingCopyToast = true
                }

                ShareLink(item: accountManager.account.publicKey.base58EncodedString) {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 50, height: 50)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(._grey100)
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(._grey100)
        .background(Color._background)
        .loading(isLoading)
        .error($error)
        .toast(isPresenting: $showingCopyToast) {
            AlertToast(displayMode: .banner(.pop), type: .complete(Color.green), title: "Copied Address")
        }
        .toast(isPresenting: $showingAirdropToast) {
            AlertToast(displayMode: .banner(.pop), type: .complete(Color.green), title: "You've received $100")
        }
    }
}

#Preview {
    ReceiveTokenView(isShowing: .constant(true), userService: UserServiceDouble())
        .environmentObject(AccountManager.create())
}

class ReceiveTokenViewModel: ObservableObject {

    func airdrop() {
    }
}
