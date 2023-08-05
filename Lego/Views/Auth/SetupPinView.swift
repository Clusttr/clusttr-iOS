//
//  SetupPinView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 03/08/2023.
//

import SwiftUI

struct SetupPinView: View {
    @State private var pin = ""

    var body: some View {
       OTPView($pin, size: 4)
            .onChange(of: pin) { pin in
                print(pin)
            }
    }
}

struct SetupPinView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPinView()
    }
}
