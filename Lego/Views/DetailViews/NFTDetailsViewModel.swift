//
//  NFTDetailsViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 20/04/2023.
//

import SwiftUI

class NFTDetailsViewModel: ObservableObject {
    @Published var similarProperties: [NFT] = NFT.fakeData
}
