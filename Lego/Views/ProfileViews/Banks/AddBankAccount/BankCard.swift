//
//  BankCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct BankCard: View {
    var bank: Bank
    var body: some View {
        HStack(spacing: 24) {
            AsyncImage(url: bank.logoURL, content: { image in
                image
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }, placeholder: {
                Spacer()
                    .frame(width: 35, height: 35)
            })

            Text(bank.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(._grey100)

            Spacer()
        }
    }
}

#Preview {
    BankCard(bank: Bank.mock())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
