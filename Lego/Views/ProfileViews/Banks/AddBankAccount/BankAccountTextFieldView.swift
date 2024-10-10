//
//  BankAccountTextFieldView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 27/09/2024.
//

import SwiftUI

struct BankAccountTextFieldView: View {
    enum Step {
        case enterAccountNumber
        case enterPin(account: BankAccount)
        case submit(account: BankAccount, pin: String)
    }

    var bankService: IBankService = BankService.create()
    var bank: Bank
    var onAccountAdded: (BankAccount) -> Void

    @State var accountNumber: String = ""
    @State var isLoading: Bool = false
    @State var step: Step = .enterAccountNumber
    @State var error: ClusttrError? = nil
    @State private var presentPinView = false

    var buttonTitle: String {
        switch step {
        case .enterAccountNumber: return "Next"
        case .enterPin: return "Enter Pin"
        case .submit: return "Add Account"
        }
    }

    var body: some View {
        VStack {
            Header<EmptyView, EmptyView>(title: "Account Details")

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

                if case let .enterPin(bankAccount) = step {
                    Text(bankAccount.accountName)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(._grey100)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            Spacer()

            ActionButton(title: buttonTitle, action: action)
            .padding(.horizontal)
        }
        .background(Color._background)
        .sheet(isPresented: $presentPinView, content: {
            EnterPinView { pin in
                guard case let .enterPin(bankAccount) = step else { return }
                step = .submit(account: bankAccount, pin: pin)
                action()
            }
            .presentationDetents([.height(250)])
        })
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

    func action() {
        switch step {
        case .enterAccountNumber:
            proceed(accountNumber: accountNumber)
        case .enterPin(_):
            showPinView()
        case .submit(let account, let pin):
            addAccount(account, pin: pin)
        }
    }

    @MainActor
    func proceed(accountNumber: String) {
        isLoading = true
        Task {
            do {
                let bankAccount = try await bankService.getBankAccountDetails(
                    for: accountNumber,
                    bank: bank.name
                )
                self.step = .enterPin(account: BankAccount(bankAccount))
                self.isLoading = false
            } catch {
                self.error = ClusttrError.networkError
                self.isLoading = false
            }
        }
    }

    func showPinView() {
        presentPinView.toggle()
    }

    @MainActor
    func addAccount(_ bankAccount: BankAccount, pin: String) {
        presentPinView = false
        isLoading = true
        Task {
            do {
                let bankAccount = try await bankService.addBankAccount(
                    AddBankAccountReqDTO(
                        accountName: bankAccount.accountName,
                        accountNumber: bankAccount.accountNumber,
                        bank: bankAccount.bank,
                        pin: pin
                    )
                )
                self.isLoading = false
                onAccountAdded(BankAccount(bankAccount))
            } catch let error as URLSession.APIError {
                self.error = ClusttrError.networkError2(error)
                self.isLoading = false
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
