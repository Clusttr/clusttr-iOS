//
//  ConfirmTransactionView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 16/03/2024.
//

import SwiftUI
import Solana

struct ConfirmTransactionView: View {
    @Binding var navPath: NavigationPath
    @Binding var isShowing: Bool
    var amount: Double
    var receiver: PublicKey

    @State var sendTx: String?
    @State var error: ClusttrError?
    @State var isLoading = false
    @EnvironmentObject var accountManager: AccountManager

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        navPath.removeLast()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    Spacer()
                    Text("Confirm Transaction")
                    Spacer()
                }
                .foregroundColor(Color._grey100)
                .fontWeight(.medium)

            }
            .padding(.horizontal, 16)
            .padding(.top, 24)

            VStack(spacing: 32) {
                Text("sending")
                    .foregroundColor(Color._grey100)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("200 USD")
                    .foregroundStyle(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                Text("To")
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                AddressView(publicKey: receiver)
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)



            Spacer()

            VStack {
                Text("Transaction Successful")

                Button {

                } label: {
                    Text("View on Solscan")
                }

            }
            .foregroundColor(Color._grey100)
            .font(.caption)
            .opacity(sendTx == nil ? 0 : 1)

            HStack(spacing: 24) {
                OutlineButton(title: "Deny")
                ActionButton(title: "Approve")
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
    }

    func sendToken() {
        isLoading = true
        Task {
            do {
                let tx = try await accountManager.sendUSDC(to: receiver, amount: amount)
                withAnimation {
                    sendTx = tx
                }
                isLoading = false
            } catch {
                self.error = ClusttrError.failedTransaction
                isLoading = false
            }
        }
    }
}

#Preview {
    ConfirmTransactionView(navPath: .constant(NavigationPath()),
                           isShowing: .constant(true),
                           amount: 100.07,
                           receiver: PublicKey(string:"DEVwHJ57QMPPArD2CyjboMbdWvjEMjXRigYpaUNDTD7o")!
    )
    .environmentObject(AccountManager.mock())
}
