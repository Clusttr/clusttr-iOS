//
//  BenefactorRow.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/07/2023.
//

import SwiftUI

struct BenefactorRow: View {
    var userService: IUserService = UserService()
    @State var benefactors: [User] = []
    @State var isSheetPresented = false
    @State private var fullSheetExpanded: Bool = false
    @State private var error: ClusttrError?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                
                Button(action: presentAddBenefactorSheet) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, design: .rounded))
                        .fontWeight(.semibold)
                        .frame(width: 45, height: 45)
                        .foregroundColor(._grey100)
                        .background {
                            LinearGradient(colors: [Color._accent.opacity(0.7), .pink.opacity(0.4)], startPoint: .topTrailing, endPoint: .bottomLeading)
                        }
                        .clipShape(Circle())
                        .padding(.leading, 16)
                }

                ForEach(benefactors) { user in
                    BenefactorCard(user: user)
                        .padding(.vertical, 4)
                }
            }
            .padding(.trailing, 16)
        }
        .frame(height: 100)
        .sheet(isPresented: $isSheetPresented) {
            AddBenefactorView(
                isSheetPresented: $isSheetPresented,
                fullSheetExpanded: $fullSheetExpanded
            )
            .presentationDetents([.height(fullSheetExpanded ? .infinity : 250)])
        }
        .task {
            getBenefactors()
        }
    }

    private func getBenefactors() {
        Task {
            do {
                let benefactors = try await userService.fetchBenefactors()
                DispatchQueue.main.async {
                    self.benefactors = benefactors.map(User.init)
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = ClusttrError.UserNotFound
//                    self.isLoading = false
                }
            }
        }
    }

    private func presentAddBenefactorSheet() {
        isSheetPresented = true
    }
}

struct BenefactorRow_Previews: PreviewProvider {
    static var previews: some View {
        BenefactorRow(userService: UserServiceDouble())
            .background(Color._background)
    }
}
