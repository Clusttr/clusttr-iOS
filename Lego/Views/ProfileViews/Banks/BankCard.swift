//
//  BankCard.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct BankCard: View {
    var userService: IUserService
    var bankAccount: BankAccount
    var onDelete: (_ bankAccountId: String) -> Void
    @State var presentDeleteDialog = false
    @State var error: ClusttrError?

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
                presentDeleteDialog = true
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
        .sheet(isPresented: $presentDeleteDialog) {
            DeleteConfirmationView(userService: userService,bankAccountId: bankAccount.id) {
                presentDeleteDialog = false
            } onProceed: { bankAccountId in
                presentDeleteDialog = false
                onDelete(bankAccountId)
            }
            .presentationDetents([.height(250)])
        }
        .error($error)

    }
}

#Preview {
    BankCard(
        userService: UserService.create(),
        bankAccount: .mock()
    ) { bankAccountId in

    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color._background)
}
