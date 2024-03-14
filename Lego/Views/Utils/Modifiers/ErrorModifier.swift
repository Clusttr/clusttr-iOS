//
//  ErrorModifier.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 14/03/2024.
//

import SwiftUI

struct ErrorModifier: ViewModifier {
    @Binding var error: ClusttrError?

    func body(content: Content) -> some View {
        content
            .blur(radius: (error != nil) ? 12 : 0)
            .overlay {
                if error != nil {
                    VStack(spacing: 12) {
                        Text("Error")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.black)

                        Text(error!.localizedDescription)
                            .font(.callout)
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 8)

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
                            error = nil
                        }
                    }

                } else {
                    EmptyView()
                }
            }
    }

    func done() {
        error = nil
    }
}

extension View {
    func error(_ error: Binding<ClusttrError?>) -> some View {
        self
            .modifier(ErrorModifier(error: error))
    }
}

#Preview {
    Web3AuthLoginView(authService: AuthServiceDouble())
        .environmentObject(AppState())
        .error(.constant(ClusttrError.failedTransaction))
}

enum ClusttrError: Error, LocalizedError {
    case failedTransaction

    var errorDescription: String? {
        switch self {
        case .failedTransaction:
            "Transaction Failed"
        }
    }
}
