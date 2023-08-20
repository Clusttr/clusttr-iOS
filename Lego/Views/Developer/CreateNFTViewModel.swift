//
//  CreateNFTViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 19/08/2023.
//

import Foundation

class CreateNFTViewModel: ObservableObject {
    let nftService: INFTService
    let DESCRIPTION_LIMIT = 60

    @Published var isLoading = false
    @Published var isShowingMessage = false
    @Published var isShowingError = false
    @Published var error: Error?
    @Published var imageURL: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
    var dismissView: (() -> Void)?

    var disableButton: Bool {
        imageURL.isEmpty || name.isEmpty || description.isEmpty
    }
    var descriptionCount: Int {
        description.count
    }

    init(nftService: INFTService = NFTService()) {
        self.nftService = nftService
    }

    func lineLimit() {
        if description.count > DESCRIPTION_LIMIT {
            description = String(description.prefix(DESCRIPTION_LIMIT))
        }
    }


    @MainActor
    func submit(userPublicKey: String) {
        isLoading = true

        let metadata = CreateNFTMetadata(name: name,image: imageURL, description: description)

        let params = CreateNFTParams(recipient: "solana:\(userPublicKey)",
                                     metadata: metadata,
                                     reuploadLinkedFiles: true)

        Task {
            let result = await nftService.mintNFT(createNFTParams: params)
            switch result {
            case .success():
                self.isShowingMessage = true
            case .failure(let error):
                print(error.localizedDescription)
                self.error = error
                self.isShowingError = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isShowingMessage = false
                self.isShowingError = false
                self.isLoading = false
                if case .success() = result {
                    self.clearForm()
                    self.dismissView?()
                }
            }
        }
    }

    func clearForm() {
        imageURL = ""
        name = ""
        description = ""
    }
}
