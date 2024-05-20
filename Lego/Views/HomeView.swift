//
//  HomeView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
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
                        NFTGrid(NFTs: viewModel.nfts.map(\.id))
                    }
                }
                .padding(.bottom, 100)
            }
            .navigationDestination(for: NFT.self) { nft in
                NFTDetailsView(nft: nft)
            }
            .navigationDestination(for: Developer.self) { _ in
                DeveloperProfileView()
            }
            .navigationDestination(for: Project.self) { project in
                ProjectDetailsView(project: project)
            }
            .task {
                viewModel.fetchNFTs()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(NFTServiceDouble())
        return HomeView(viewModel: viewModel)
            .environmentObject(AppState())
    }
}

class HomeViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    let nftService: INFTService

    init(_ nftService: INFTService = NFTService()) {
        self.nftService = nftService
    }

    @MainActor
    func fetchNFTs() {
        Task {
            do {
                self.nfts = try await nftService.fetchNFts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
