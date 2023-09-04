//
//  LoadingModifier.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    var isLoading: Bool
    var loaderType: LoaderType

    func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .blur(radius: isLoading ? 5 : 0)
            .overlay {
                if isLoading {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 100)
                            .background(Color._grey800)
                            .cornerRadius(8)
                            .opacity(loaderType.showBackground ? 0.5 : 0)

                        LottieView(name: loaderType.lottiURI, size: CGSize(width: 25, height: 25), loopMode: .repeat(.infinity))
                            .scaleEffect(0.25)
                    }
                } else {
                    EmptyView()
                }
            }
    }
}

extension View {
    func loading(_ isLoading: Bool, loaderType: LoaderType = .regular) -> some View {
        self
            .modifier(LoadingModifier(isLoading: isLoading, loaderType: loaderType))
    }
}

enum LoaderType {
    case regular
    case mintingAsset

    var lottiURI: String {
        switch self {
        case .regular:
            return "loading"
        case .mintingAsset:
            return "construction_progress"
        }
    }

    var showBackground: Bool {
        switch self {
        case .regular:
            return true
        case .mintingAsset:
            return false
        }
    }
}

struct LoadingModifier_Previews: PreviewProvider {
    static var previews: some View {
        Web3AuthLoginView(authService: AuthServiceDouble())
            .environmentObject(AppState())
            .loading(true)
    }
}
