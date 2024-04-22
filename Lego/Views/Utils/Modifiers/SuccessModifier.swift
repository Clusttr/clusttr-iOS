//
//  SuccessModifier.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/03/2024.
//

import SwiftUI

struct SuccessModifier: ViewModifier {
    @Binding var isShowing: Bool

    func body(content: Content) -> some View {
        content
            .blur(radius: isShowing ? 5 : 0)
            .overlay {
                if isShowing {
                    VStack(spacing: 36) {
                        Text("Success")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.black)

                        Button(action: done) {
                            HStack {
                                Text("Done")
                            }
                            .actionButtonStyle(disabled: false)
                        }
                        .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .background(Color._grey)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            isShowing = false
                        }
                    }

                } else {
                    EmptyView()
                }
            }
    }

    func done() {
        isShowing = false
    }
}

extension View {
    func success(_ isShowing: Binding<Bool>) -> some View {
        self
            .modifier(SuccessModifier(isShowing: isShowing))
    }
}

#Preview {
    Web3AuthLoginView(authService: AuthServiceDouble())
        .environmentObject(AppState())
        .success(.constant(true))
}
