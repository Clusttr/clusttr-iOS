//
//  OTPField.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 05/08/2023.
//

import SwiftUI
import Combine

struct OTPField: View {
    @State var text = ""
    var onChange: (_ tex: String) -> Void
    let LIMIT = 1
    @FocusState private var focus: Bool

    init(focus: Bool, _ onChange: @escaping (_ tex: String) -> Void) {
        self.onChange = onChange
        self.focus = focus
    }

    var body: some View {
        TextField("", text: $text)
            .font(.headline)
            .foregroundColor(Color._grey100)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { _ in
                lineLimit()
            }
            .frame(width: 45, height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color._grey700, lineWidth: 1)
            }
    }

    func lineLimit() {
        if text.count > LIMIT {
            text = String(text.prefix(LIMIT))
        }
        onChange(text)
    }
}

struct OTPField_Previews: PreviewProvider {
    static var previews: some View {
        OTPField(focus: true) { _ in }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color._background)
    }
}
