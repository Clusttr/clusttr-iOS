//
//  BankCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct BankCard: View {
    var bankAccount: BankAccount
    var onDelete: (_ bankAccount: BankAccount) -> Void

    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("0025635480")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color._grey100)
                Text("Matthew Chukwuemeka")
                    .font(.footnote)
                    .foregroundColor(._grey2)
                Text("Access Bank")
                    .font(.caption)
                    .foregroundColor(._grey100)
            }

            Spacer()

            Button(action: {
                onDelete(bankAccount)
            }) {
                Image(systemName: "trash")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color._grey800)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

    }
}

#Preview {
    BankCard(bankAccount: .mock()) { bankAccount in

    }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
