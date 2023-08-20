//
//  CreateNFTView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import AlertToast
import Combine
import SwiftUI

struct CreateNFTView: View {
    @StateObject var viewModel: CreateNFTViewModel = CreateNFTViewModel()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var accountManager: AccountManager

    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .bottom, spacing: 16) {
                DismissButton()
                Text("Register Property")
                    .font(.title2)
                    .foregroundColor(Color._grey100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
            }

            NFTImagePicker(imageURL: $viewModel.imageURL)

            TextField("Name", text: $viewModel.name)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .font(.callout)
                .font(.callout)
                .background(Color._grey800)
                .cornerRadius(8)
                .foregroundColor(Color._grey2)
                .padding(.top, 30)
                .padding(.horizontal)


            VStack(alignment: .leading) {
                Text("Description")
                    .font(.caption)
                    .foregroundColor(Color._grey100)
                    .fontWeight(.semibold)
                    .opacity(0.75)

                TextEditor(text: $viewModel.description)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .font(.callout)
                    .font(.callout)
                    .frame(height: 120)
                    .scrollContentBackground(.hidden)
                    .background(Color._grey800)
                    .cornerRadius(8)
                    .foregroundColor(Color._grey2)
                    .onReceive(Just(viewModel.description)) { _ in
                        viewModel.lineLimit()
                    }

                Text("(\(viewModel.descriptionCount)/\(viewModel.DESCRIPTION_LIMIT)")
                    .font(.caption2)
                    .foregroundColor(viewModel.DESCRIPTION_LIMIT == viewModel.descriptionCount ? Color.red : Color._grey100)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)

            Spacer()

            ActionButton(title: "Submit", disabled: viewModel.disableButton) {
                viewModel.submit(userPublicKey: accountManager.account.publicKey.base58EncodedString)
            }
            .padding(.horizontal)

        }
        .background(Color._background)
        .navigationBarBackButtonHidden(true)
        .padding(.vertical, 36)
        .padding(.bottom, 16)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut) {
                appState.isNavBarHidden = true
            }
            viewModel.dismissView = dismissView
        }
        .blur(radius: viewModel.isLoading ? 5 : 0)
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Rectangle()
                        .opacity(0.3)
                        .blur(radius: 30)
                    LottieView(name: "construction_progress", loopMode: .loop)
                        .scaleEffect(0.25)
                }
            } else {
                EmptyView()
            }
        }
        .toast(isPresenting: $viewModel.isShowingMessage) {
            AlertToast(displayMode: .alert, type: .complete(Color.green), title: "Mint Successful")
        }
        .toast(isPresenting: $viewModel.isShowingError) {
            AlertToast(displayMode: .alert, type: .error(Color.red), title: viewModel.error?.localizedDescription )
        }
    }

    func dismissView() {
        appState.developerPath = []
        appState.isNavBarHidden = false
    }
}

struct CreateNFTView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CreateNFTViewModel(nftService: NFTServiceDouble())
        viewModel.imageURL = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRZJ8awhuWhiqwRb_H8xEh6SaFcll2D2c-1ye4ZK03fgwzxUz9P"
        return CreateNFTView(viewModel: viewModel)
                .background(Color._background)
                .environmentObject(AppState())
                .environmentObject(AccountManager(.dev))
    }
}
