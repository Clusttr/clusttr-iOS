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
    @FocusState private var focus: Bool

    var activeIndex: Int {
        pin.count
    }

    init(_ pin: Binding<String>, size: Int) {
        self._pin = pin
        viewModel = OTPViewModel(size: size)
    }

    var body: some View {
        HStack {
            ForEach(Array(viewModel.arr.enumerated()), id: \.0) { index, _ in
                OTPBoxView(value: pin.charAt(index))
            }
            TextField("", text: $pin)
                .keyboardType(.numberPad)
                .frame(width: 0, height: 0)
                .focused($focus)
        }
        .onChange(of: pin) { oldValue, newValue in
            print(newValue)
            print("activeIndex: \(activeIndex)")
        }
        .onAppear {
            focus = true
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(.constant(""), size: 4)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color._background)
    }
}

class OTPViewModel: ObservableObject {
    var arr: [String]

    init(size: Int) {
        arr = [String](repeating: "", count: size)
    }
}

extension String {
    func charAt(_ n: Int) -> Character? {
        guard n >= 0 && n < self.count else { return nil }
        return self[index(startIndex, offsetBy: n)]
    }
}
