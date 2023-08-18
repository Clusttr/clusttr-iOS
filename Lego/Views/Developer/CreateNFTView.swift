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
                viewModel.submit()
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
    }

    func dismissView() {
        appState.developerPath = []
    }
}

struct CreateNFTView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNFTView()
            .background(Color._background)
            .environmentObject(AppState())
    }
}

class CreateNFTViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isShowingMessage = false
    @Published var imageURL: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
    let DESCRIPTION_LIMIT = 60
    var descriptionCount: Int {
        description.count
    }

    var dismissView: (() -> Void)?

    var disableButton: Bool {
        imageURL.isEmpty || name.isEmpty || description.isEmpty
    }

    func lineLimit() {
        if description.count > DESCRIPTION_LIMIT {
            description = String(description.prefix(DESCRIPTION_LIMIT))
        }
    }

    func submit() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.isLoading = false
            self.clearForm()
            self.isShowingMessage = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isShowingMessage = false
                self.dismissView?()
            }
        }
    }

    func clearForm() {
        imageURL = ""
        name = ""
        description = ""
    }
}
