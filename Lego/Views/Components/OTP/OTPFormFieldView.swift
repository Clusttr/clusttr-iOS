//
//  OTPFormFieldView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 03/08/2023.
//

import SwiftUI
import Combine

private struct OTPTextField: View {
    @Binding var pin: String
//    var onChange: () => Void

    var body: some View {
        TextField("", text: $pin)
            .modifier(OTPModifier(pin:$pin))
//            .onChange(of:pinOne){newVal in
//                if (newVal.count == 1) {
//                    onChange()
//                }
//            }
//            .focused($pinFocusState, equals: .pinOne)
            .background(Color.green)
    }

}

struct OTPFormFieldView: View {
    //MARK -> PROPERTIES

    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour
    }

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""


    //MARK -> BODY
    var body: some View {
        HStack(spacing:15, content: {

            TextField("", text: $pinOne)
                .modifier(OTPModifier(pin:$pinOne))
                .onChange(of:pinOne){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinOne)

            TextField("", text:  $pinTwo)
                .modifier(OTPModifier(pin:$pinTwo))
                .onChange(of:pinTwo){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinThree
                    }else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinOne
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinTwo)


            TextField("", text:$pinThree)
                .modifier(OTPModifier(pin:$pinThree))
                .onChange(of:pinThree){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinFour
                    }else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinTwo
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinThree)


            TextField("", text:$pinFour)
                .modifier(OTPModifier(pin:$pinFour))
                .onChange(of:pinFour){newVal in
                    if (newVal.count == 0) {
                        pinFocusState = .pinThree
                    }
                }
                .focused($pinFocusState, equals: .pinFour)


        })
        .padding(.vertical)

    }
}


struct OTPFormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OTPFormFieldView()
    }
}
