//
//  ProfileViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/04/2023.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var NFTs: [NFT] = []
    @Published var searchWord = ""
    let dataSource: [NFT] = NFT.fakeData
    var subscription = Set<AnyCancellable>()

    init() {
        $searchWord
            .sink { [weak self] searchWord in
                guard let self = self else { return }
                self.NFTs = searchWord.isEmpty ? self.dataSource : self.dataSource.filter{ $0.name.contains(searchWord) }
            }
            .store(in: &subscription)
    }
}
