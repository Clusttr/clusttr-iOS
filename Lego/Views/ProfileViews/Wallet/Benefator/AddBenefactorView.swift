//
//  AddBenefactorView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 21/09/2024.
//

import SwiftUI
import Solana
import AlertToast

struct AddBenefactorView: View {
    var userService: IUserService = UserService()
    @Binding var isSheetPresented: Bool
    @Binding var fullSheetExpanded: Bool
    @State private var addressText: String = ""
    @State private var isLoading = false
    @State private var user: User?
    @State private var error: ClusttrError?
    @State private var showingSuccess: Bool = false

    var pubkey: PublicKey? {
        PublicKey(string: addressText)
    }

    var actionButtonTitle: String {
        user == nil ? "Find" : "Add Benefactor"
    }

    var actionButtonDisabled: Bool {
        pubkey == nil || isLoading
    }
    var body: some View {
        VStack {
            Text("Add Benefactor")
                .font(.title3)
                .foregroundColor(._grey100)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.bottom, 24)

            Spacer()

            if let user = user {
                BenefactorInfoView(user: user)
            }

            Spacer()

            searchBar
                .padding(.bottom, 32)

            ActionButton(
                title: actionButtonTitle,
                disabled: actionButtonDisabled,
                action: buttonAction
            )
        }
        .padding(16)
        .background(Color._background.opacity(0.95))
        .sensoryFeedback(.success, trigger: showingSuccess)
        .toast(isPresenting: $showingSuccess) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .complete(Color.green),
                title: "Benefactor added"
            )
        }
        .error($error)

    }

    var searchBar: some View {
        HStack {
            HStack {
                TextField("Search", text: $addressText)
                    .placeholder(when: addressText.isEmpty) {
                        Text("Enter Address")
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

            Image(systemName: "qrcode.viewfinder")
                .foregroundColor(.white.opacity(0.7))
        }
    }

    func buttonAction() {
        if let user = user {
            addBenefactor(user.id)
        } else {
            guard let pubkey = pubkey else { return }
            findUser(pubkey)
        }
    }

    func findUser(_ pubkey: PublicKey) {
        isLoading = true
        Task {
            do {
                let user = try await userService.find(by: pubkey.base58EncodedString)
                DispatchQueue.main.async {
                    self.fullSheetExpanded = true
                    self.user = User(user)
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = ClusttrError.UserNotFound
                    self.isLoading = false
                }
            }
        }
    }

    func addBenefactor(_ id: String) {
        isLoading = true
        Task {
            do {
                let _ = try await userService.addBenefactor(id: id)
                DispatchQueue.main.async{
                    self.showingSuccess = true
                    self.isLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                        self.fullSheetExpanded = false
                        self.isSheetPresented = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = ClusttrError.UserNotFound
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    AddBenefactorView(
        userService: UserServiceDouble(),
        isSheetPresented: .constant(true),
        fullSheetExpanded: .constant(true)
    )
}
