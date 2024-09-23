//
//  AddBenefactorView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 21/09/2024.
//

import SwiftUI
import Solana

struct AddBenefactorView: View {
    var userService: IUserService = UserService()
    @Binding var isSheetPresented: Bool
    @Binding var fullSheetExpanded: Bool
    @State private var searchWord: String = ""
    @State private var isPubkeyValid: Bool = false
    @State private var isLoading = false
    @State private var rotationAngle: Double = 0
    @State private var hearthBeat = false
    @State private var isRotating = true
    @State private var user: User?
    @State private var error: ClusttrError?

    var pubkey: PublicKey? {
        PublicKey(string: searchWord)
    }

    var actionButtonTitle: String {
        pubkey == nil ? "Find" : "Add Benefactor"
    }

    var actionButtonDisabled: Bool {
        pubkey == nil && isLoading
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

            UserView(user)

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
        .error($error)

    }

    var searchBar: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchWord)
                    .placeholder(when: searchWord.isEmpty) {
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

    let gradient = AngularGradient(
        colors: [._accent, .white, ._accent.opacity(0.6)],
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0)
    )

    @ViewBuilder
    func UserView(_ user: User?) -> some View {
        if let user = user {
            VStack {
                Image.ape
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(gradient, lineWidth:  6)
                            .blur(radius: 16)
                            .scaleEffect(hearthBeat ? 1.1 : 0.9)
                            .animation(
                                isRotating ? Animation.linear(duration: 1.0)
                                    .repeatForever(autoreverses: true) : .default,
                                value: rotationAngle
                            )
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(
                                isRotating ? Animation.linear(duration: 2.0)
                                    .repeatForever(autoreverses: false) : .default,
                                value: rotationAngle
                            )
                            .onAppear {
                                rotationAngle = 360
                                hearthBeat = true
                            }
                    }

                Text("@\(user.name)")
                    .font(.headline)
                    .foregroundColor(._grey100)
                    .padding(.top, 24)

                Text("HKz1...i8Op")
                    .font(.caption)
                    .foregroundColor(._grey2)
            }
        } else {
            VStack { EmptyView() }
        }
    }

    func onSearchBarFocused(_ value: Bool) {

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
        Task {
            do {
                let user = try await userService.find(by: pubkey.base58EncodedString)
                DispatchQueue.main.async {
                    self.fullSheetExpanded = true
                    self.user = User(user)
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = ClusttrError.UserNotFound
                }
            }
        }
    }

    func addBenefactor(_ id: String) {
        Task {
            do {
                let _ = try await userService.addBenefactor(id: id) //persist benefactor
                DispatchQueue.main.async{
                    self.isSheetPresented = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = ClusttrError.UserNotFound
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
