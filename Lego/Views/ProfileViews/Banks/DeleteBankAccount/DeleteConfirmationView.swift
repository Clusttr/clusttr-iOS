//
//  DeleteConfirmationView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct DeleteConfirmationView: View {
    var bankService: IBankService = BankService.create()
    var bankAccount: BankAccount
    var onDismiss: () -> Void
    var onProceed: (_ bankAccount: BankAccount) -> Void
    @State private var pin = ""
    @State private var isLoading: Bool = false
    @State private var error: ClusttrError?

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Delete Bank")
                }
                .font(.headline)
                .foregroundColor(._grey100)

                Text("Are you sure you want to proceed with this action?\nPlease enter the 4-digit OTP code provided by your bank.")
                    .font(.footnote)
                    .foregroundColor(._grey2)
            }

            Spacer()

            OTPView($pin, size: 4)

            Spacer()

            HStack(spacing: 16) {
                OutlineButton(title: "Cancel", action: onDismiss)
                ActionButton(title: "Proceed") {
                    Task {
                        await deleteAccount()
                    }
                }
            }
        }
        .padding()
        .background(Color._background.opacity(0.9))
        .loading(isLoading)
        .error($error)
    }

    @MainActor
    func deleteAccount() async {
        isLoading = true
        do {
            let bankAccount = try await bankService
                .deleteBankAccount(
                    accountNumber: bankAccount.accountNumber,
                    bank: bankAccount.bank,
                    pin: pin
                )
            isLoading = false
            onProceed(BankAccount(bankAccount))

        } catch let error as URLSession.APIError {
           self.error = ClusttrError.networkError2(error)
           isLoading = false
       } catch {
            self.error = ClusttrError.networkError
            isLoading = false
        }
    }
}

#Preview {
    DeleteConfirmationView(
        bankService: BankService.create(),
        bankAccount: BankAccount.mock()
    ) {

    } onProceed: { bankAccountId in

    }
}
