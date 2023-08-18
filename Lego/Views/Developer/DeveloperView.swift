//
//  DeveloperView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/08/2023.
//

import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack(path: $appState.developerPath) {
            VStack {
                DeveloperWelcomeView()
            }
            .navigationDestination(for: DeveloperPath.self) { path in
                path
            }
        }
        .background(Color._background)
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = false
            }
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
            .environmentObject(AppState())
    }
}
