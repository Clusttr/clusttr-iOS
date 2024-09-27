//
//  AddBankAccountView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct AddBankAccountView: View {
    @State var accountNumber: String = ""

    enum step {
        case pickBank
        case enterAccountNuber
    }

    var body: some View {
        VStack {
            HStack {
                Text("Add Bank Account")
            }
            .font(.headline)
            .foregroundColor(._grey100)

            TextField(text: $accountNumber) {
                Text("Enter account number")
                    .foregroundColor(._grey2)
            }
            .foregroundColor(._grey100)
        }
    }
}

#Preview {
    AddBankAccountView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
