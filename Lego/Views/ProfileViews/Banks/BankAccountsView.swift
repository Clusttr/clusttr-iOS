//
//  BanksView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import AlertToast
import SwiftUI

struct BankAccountsView: View {
    var onClickMenu: () -> Void
    var userService = UserService.create()
    @State private var bankAccounts: [BankAccount] = []
    @State private var presentingAddBankAccount: Bool = false
    @State private var addSuccessAlert = false
    @State private var deleteSuccessAlert = false
    @State private var error: ClusttrError?

    @State var cardToDeleteId: String?

    var body: some View {
        VStack {
            Header(title: "Bank Accounts") {
                Button("", systemImage: "plus") {
                    presentingAddBankAccount = true
                }
                .foregroundColor(._grey100)
                .fontWeight(.bold)
            } trailingView: {
                Button("", systemImage: "line.3.horizontal", action: onClickMenu)
                .foregroundColor(._grey100)
                .fontWeight(.bold)
            }

            ScrollView {
                VStack {
                    ForEach(bankAccounts) { bankAccount in
                        BankAccountCard(userService: userService, bankAccount: bankAccount) { bankAccount in
                            bankAccounts.removeAll(where: {
                                $0.accountNumber == bankAccount.accountNumber &&
                                $0.bank == bankAccount.bank
                            })
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
        .toast(isPresenting: $addSuccessAlert) {
            AlertToast(displayMode: .banner(.pop), type: .complete(Color.green), title: "Account Added")
        }
        .toast(isPresenting: $deleteSuccessAlert) {
            AlertToast(displayMode: .banner(.pop), type: .complete(Color.green), title: "Account deleted")
        }
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
    BankAccountsView() { }
}
