//
//  BanksView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct BankAccountsView: View {
    var userService = UserService.create()
    @State var bankAccounts: [BankAccount] = []
    @State var presentingAddBankAccount: Bool = false
    @State var error: ClusttrError?

    @State var cardToDeleteId: String?

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Bank Accounts")
                    .foregroundColor(Color._grey100)
                Spacer()

                Button("", systemImage: "plus") {
                    presentingAddBankAccount = true
                }
                .foregroundColor(._grey100)
                .fontWeight(.bold)
            }
            ScrollView {
                VStack {
                    ForEach(bankAccounts) { bankAccount in
                        BankAccountCard(userService: userService, bankAccount: bankAccount) { bankAccountId in
                            bankAccounts.removeAll(where: { $0.id == bankAccountId })
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
        }
        .padding(.top, 50)
        .background(Color._background)
        .sheet(isPresented: $presentingAddBankAccount, content: {
            AddBankAccountView() { bankAccount in
                bankAccounts.append(bankAccount)
                presentingAddBankAccount = false
            }
        })
        .task {
            await fetchBankAccounts()
        }
    }

    @MainActor
    func fetchBankAccounts() async {
        do {
            let bankAccounts = try await userService.fetchBankAccounts()
            self.bankAccounts = bankAccounts.map(BankAccount.init)
        } catch {
            self.error = ClusttrError.networkError
        }
    }
}

#Preview {
    BankAccountsView()
}
