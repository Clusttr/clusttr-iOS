//
//  AccountInfoView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/08/2023.
//

import SwiftUI

struct AccountInfoView: View {
    @EnvironmentObject var accountManager: AccountManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Clusttr wallet operates on the secure Solana blockchain, providing you with a reliable and efficient platform for real estate investment. The dollar balance in your account is backed by USDC (USD Coin), ensuring the stability and security of your funds throughout your investment journey.")
                .font(.caption2)

            HStack(spacing: 4) {
                Text("Sol Balance:")
                Text("\(accountManager.balance.convertToBalance(decimals: 9))")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }

            HStack(spacing: 4) {
                Text("View account on")
                Link("SolarScan", destination: accountManager.account.publicKey.accountURL)
                    .foregroundColor(Color._accent.opacity(0.75))
                    .fontWeight(.bold)
            }
        }
        .font(.caption)
        .padding()
        .foregroundColor(Color._grey100)

    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
            .background(Color._background)
            .environmentObject(AccountManager.create())
    }
}
