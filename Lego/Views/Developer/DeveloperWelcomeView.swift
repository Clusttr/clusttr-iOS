//
//  DeveloperWelcomeView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import SwiftUI

struct DeveloperWelcomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Tokenise your first asset")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color._grey100)

            ActionButton(title: "Next") {
                appState.developerPath.append(DeveloperPath.createNFT)
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color._background)
    }
}

struct DeveloperWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperWelcomeView()
            .background(Color._background)
    }
}
