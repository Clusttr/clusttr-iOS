//
//  BankAccountTextFieldView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct BankAccountTextFieldView: View {
    var bankService: IBankService = BankService.create()
    var bank: Bank
    var onAccountAdded: (BankAccount) -> Void

    @State var accountNumber: String = ""
    @State var isLoading: Bool = false
    @State var bankAccount: BankAccount? = nil
    @State var error: ClusttrError? = nil

    var body: some View {
        VStack {
            Header(title: "Account Details")

            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Bank")
                        .font(.subheadline)
                        .foregroundColor(._grey100)
                    BankCard(bank: bank)
                        .padding(8)
                        .background(Color._grey800)
                }

                VStack(alignment: .leading) {
                    Text("Account Number")
                        .font(.subheadline)
                        .foregroundColor(._grey100)
                    accountField
                }

                if bankAccount != nil {
                    Text(bankAccount!.name)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(._grey100)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            Spacer()

            ActionButton(title: bankAccount == nil ? "Proceed" : "Add Account") {
                bankAccount == nil ? proceed(accountNumber: accountNumber) : addAccount(bankAccount!)
            }
            .padding(.horizontal)
        }
        .background(Color._background)
        .loading(isLoading)
        .error($error)
    }

    var accountField: some View {
        HStack {
            HStack {
                TextField("Search", text: $accountNumber)
                    .placeholder(when: accountNumber.isEmpty) {
                        Text("Enter your account number")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .accentColor(.red)
                    .foregroundColor(.white)
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(.white.opacity(0.07))
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.3))
            }
            Image(systemName: "document.on.clipboard")
                .foregroundColor(.white.opacity(0.7))
        }
    }

    @MainActor
    func proceed(accountNumber: String) {
        isLoading = true
        Task {
            do {
                let bankAccount = try await bankService.getBankAccount(
                    for: accountNumber,
                    bank: bank.id
                )
                self.bankAccount = BankAccount(bankAccount)
                self.isLoading = false
            } catch {
                self.error = ClusttrError.networkError
                self.isLoading = false
            }
        }
    }

    @MainActor
    func addAccount(_ bankAccount: BankAccount) {
        isLoading = true
        Task {
            do {
                let bankAccount = try await bankService.addBankAccount(
                    BankAccountReqDTO(
                        name: bankAccount.name,
                        accountNumber: bankAccount.accountNumber,
                        bankName: bankAccount.bankName
                    )
                )
                self.isLoading = false
                onAccountAdded(BankAccount(bankAccount))
            } catch {
                self.error = ClusttrError.networkError
                self.isLoading = false
            }
        }
    }
}

#Preview {
    BankAccountTextFieldView(bank: .mock()) { bankAccount in

    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
}
