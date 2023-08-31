//
//  ProfileViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/04/2023.
//

import Foundation
import Combine
import Solana

class ProfileViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var searchWord = ""
    let nftService: INFTService
    var subscription = Set<AnyCancellable>()

    init(_ nftService: INFTService = NFTService()) {
        self.nftService = nftService
        //$searchWord
        //.sink { [weak self] searchWord in
        //    guard let self = self else { return }
        //    self.nfts = searchWord.isEmpty ? self.dataSource : self.dataSource.filter{ $0.name.contains(searchWord) }
        //}
        //.store(in: &subscription)
    }


    @MainActor
    func fetchNFTs(userPublicKey: PublicKey) {
        Task {
            do {
                let result = try await nftService.fetchNFts()
                self.nfts = result.filter({ nft in
                    nft.owner == userPublicKey
                })
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
