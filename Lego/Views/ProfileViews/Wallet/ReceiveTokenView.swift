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
    @State var showingCopyToast = false
    @EnvironmentObject var accountManager: AccountManager

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
                AddressView(account: accountManager.account)
                    .padding(.top, 32)
            }
            .offset(y: -50)


            Spacer()
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
        .toast(isPresenting: $showingCopyToast) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Copied Address")
        }
    }
}

#Preview {
    ReceiveTokenView(isShowing: .constant(true))
        .environmentObject(AccountManager.mock())
}
