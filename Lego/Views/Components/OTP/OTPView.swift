//
//  OTPView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 05/08/2023.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: OTPViewModel
    @FocusState var focusField: Bool
    @Binding var pin: String

    init(_ pin: Binding<String>, size: Int) {
        self._pin = pin
        viewModel = OTPViewModel(size: size)
    }

    var body: some View {
        HStack {
            ForEach(Array(viewModel.arr.enumerated()), id: \.0) { index, _ in
                OTPField(focus: index == 2) { text in
                    viewModel.arr[index] = text
                    pin = String(viewModel.arr.joined())
//                    print(viewModel.arr)
                }
            }
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(.constant(""), size: 6)
    }
}

class OTPViewModel: ObservableObject {
    var arr: [String]

    init(size: Int) {
        arr = [String](repeating: "", count: size)
        print("re-init")
    }
}

struct ActiveField: Hashable {
    var string = ""
}
