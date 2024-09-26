//
//  BanksView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 26/09/2024.
//

import SwiftUI

struct BanksView: View {
    var userService = UserService.create()
    @State var presentDeleteDialog = false
    @State var bankAccounts: [BankAccount] = []
    @State var error: ClusttrError?
    @State var isLoading: Bool = false

    @State var cardToDeleteId: String?

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Bank Accounts")
                    .foregroundColor(Color._grey100)
                Spacer()

                Button("", systemImage: "plus") {

                }
                .foregroundColor(._grey100)
                .fontWeight(.bold)
            }
            ScrollView {
                VStack {
                    ForEach(bankAccounts) { bankAccount in
                        BankCard(bankAccount: bankAccount) { bankAccount in
                            cardToDeleteId = bankAccount.id
                            presentDeleteDialog = true
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
        }
        .background(Color._background)
        .sheet(isPresented: $presentDeleteDialog) {
            DeleteConfirmationView(bankAccountId: cardToDeleteId ?? "") {
                presentDeleteDialog = false
            } proceed: { bankAccountId, pin in
                Task {
                    await deleteAccount(id: cardToDeleteId!, pin: pin)
                }
            }
            .presentationDetents([.height(250)])
        }
        .error($error)
        .loading(isLoading)
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

    @MainActor
    func deleteAccount(id bankAccountId: String, pin: String) async {
        isLoading = true
        do {
            let bankAccount = try await userService.deleteBankAccount(id: bankAccountId, pin: pin)
            DispatchQueue.main.async {
                bankAccounts.removeAll(where: { $0.id == bankAccountId })
                presentDeleteDialog = false
                isLoading = false
            }
        } catch {
            self.error = ClusttrError.networkError
            presentDeleteDialog = false
            isLoading = false
        }
    }
}

#Preview {
    BanksView()
}
