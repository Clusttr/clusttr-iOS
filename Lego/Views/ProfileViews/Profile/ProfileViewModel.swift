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
    @Published var user: User?
    @Published var nfts: [NFT] = []
    @Published var searchWord = ""
    let nftService: INFTService
    let userService: IUserService
    var subscription = Set<AnyCancellable>()

    init(userService: IUserService = UserService(), nftService: INFTService = NFTService()) {
        self.userService = userService
        self.nftService = nftService
        //$searchWord
        //.sink { [weak self] searchWord in
        //    guard let self = self else { return }
        //    self.nfts = searchWord.isEmpty ? self.dataSource : self.dataSource.filter{ $0.name.contains(searchWord) }
        //}
        //.store(in: &subscription)
    }

    @MainActor
    func fetchUserProfile() {
        Task {
            do {
                let res = try await userService.fetchUser()
                self.user = User(res)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
