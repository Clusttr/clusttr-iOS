//
//  CreateNFTView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/08/2023.
//

import SwiftUI

struct CreateNFTView: View {
    @StateObject var viewModel: CreateNFTViewModel = CreateNFTViewModel()

    var body: some View {
        VStack(spacing: 24) {
            Text("Register Property")
                .font(.title2)
                .foregroundColor(Color._grey400)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
                .padding(.bottom, 24)

            VStack(spacing: 8) {
                Image(systemName: "photo")
                Text("Click here to paste image")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .frame(height: 180)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color._grey400)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(._grey400)
            }

            TextField("Name", text: $viewModel.name)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .font(.callout)
                .font(.callout)
                .background(Color._grey800)
                .cornerRadius(8)
                .foregroundColor(Color._grey2)
                .padding(.top, 30)

            TextEditor(text: $viewModel.description)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .font(.callout)
                .font(.callout)
                .frame(height: 170)
                .scrollContentBackground(.hidden)
                .background(Color._grey800)
                .cornerRadius(8)
                .foregroundColor(Color._grey2)

            Spacer()

            ActionButton(title: "Submit")

        }
        .padding(.horizontal)

    }
}

struct CreateNFTView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNFTView()
            .background(Color._background)
    }
}

class CreateNFTViewModel: ObservableObject {
    @Published var imageLink: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
}
