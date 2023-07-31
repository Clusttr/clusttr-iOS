//
//  HomeView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct HomeView: View {
    @State var NFTs: [NFT] = NFT.fakeData
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Interesting Projects")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        ProjectCarousel()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Popular Developers")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        PopularDeveloperRow()
                    }


                    VStack(alignment: .leading, spacing: 4) {
                        Text("Trending")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        NFTGrid(NFTs: NFTs)
                    }
                }
                .padding(.bottom, 100)
            }
            .onAppear {appState.loginState = .loggedIn }
            .navigationDestination(for: NFT.self) { nft in
                NFTDetailsView(nft: nft)
            }
            .navigationDestination(for: Developer.self) { _ in
                DeveloperProfileView()
            }
            .navigationDestination(for: Project.self) { project in
                ProjectDetailsView(project: project)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState())
    }
}
