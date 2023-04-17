//
//  CustomShape.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 15/04/2023.
//

import SwiftUI

struct AdjustableBannerShape: Shape {
    @ObservedObject var viewModel: AdjustableBannerShapeViewModel
    private var incrementalSteps = 200.0 / 0.6965

    init(viewModel: AdjustableBannerShapeViewModel) {
        self.viewModel = viewModel
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))

        //cp1
        path.addLine(to: CGPoint(x: width, y: viewModel.cp1*height))

        //cp2
        path.addLine(to: CGPoint(x: viewModel.cp21*width, y: viewModel.cp22*height))

        //cp3
        path.addCurve(to: CGPoint(x: viewModel.cp31*width, y: viewModel.cp32*height), control1: CGPoint(x: viewModel.cp33*width, y: viewModel.cp34*height), control2: CGPoint(x: viewModel.cp35*width, y: viewModel.cp36*height))

        //cp4
        path.addLine(to: CGPoint(x: viewModel.cp41*width, y: viewModel.cp42*height))

        //cp5
        path.addCurve(to: CGPoint(x: viewModel.cp51*width, y: viewModel.cp52*height), control1: CGPoint(x: viewModel.cp53*width, y: viewModel.cp54*height), control2: CGPoint(x: viewModel.cp55*width, y: viewModel.cp56*height))

        //cp6
        path.addLine(to: CGPoint(x: viewModel.cp61*width, y: viewModel.cp62*height))

        //cp7
        path.addCurve(to: CGPoint(x: viewModel.cp71*width, y: viewModel.cp72*height), control1: CGPoint(x: viewModel.cp73*width, y: viewModel.cp74*height), control2: CGPoint(x: viewModel.cp75*width, y: viewModel.cp76*height))

        //cp8
        path.addLine(to: CGPoint(x: 0, y: viewModel.cp8*height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

struct MyCustomShape_Previews: PreviewProvider {
    static var previews: some View {
        AdjustableBannerShape(viewModel: .init(offset: .zero))
    }
}
