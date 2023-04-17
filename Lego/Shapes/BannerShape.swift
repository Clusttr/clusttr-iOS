//
//  MyCustomShape.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import SwiftUI

struct BannerShape: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0.6965*height))
            path.addLine(to: CGPoint(x: 0.93407*width, y: 0.71598*height))
            path.addCurve(to: CGPoint(x: 0.67476*width, y: 0.88187*height), control1: CGPoint(x: 0.84319*width, y: 0.74285*height), control2: CGPoint(x: 0.75547*width, y: 0.79896*height))
            path.addLine(to: CGPoint(x: 0.61076*width, y: 0.94762*height))
            path.addCurve(to: CGPoint(x: 0.39312*width, y: 0.93522*height), control1: CGPoint(x: 0.54238*width, y: 1.01787*height), control2: CGPoint(x: 0.45911*width, y: 1.01312*height))
            path.addLine(to: CGPoint(x: 0.38948*width, y: 0.93091*height))
            path.addCurve(to: CGPoint(x: 0.0689*width, y: 0.71361*height), control1: CGPoint(x: 0.29219*width, y: 0.81604*height), control2: CGPoint(x: 0.18284*width, y: 0.74193*height))
            path.addLine(to: CGPoint(x: 0, y: 0.6965*height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
            return path
        }
}

struct BannerShape_Previews: PreviewProvider {
    static var previews: some View {
        BannerShape()
    }
}
