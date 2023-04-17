//
//  AdjustableBannerShapeViewModel.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/04/2023.
//

import Foundation

class AdjustableBannerShapeViewModel: ObservableObject {

    @Published var offset: CGFloat = .zero

    private var rectangleHeight = 0.6965

    @Published var cp1 = 0.6965

    @Published var cp21 = 0.93407
    @Published var cp22 = 0.71598

    @Published var cp31 = 0.67476
    @Published var cp32 = 0.88187
    @Published var cp33 = 0.84319
    @Published var cp34 = 0.74285
    @Published var cp35 = 0.75547
    @Published var cp36 = 0.79896

    @Published var cp41 = 0.61076
    @Published var cp42 = 0.94762

    @Published var cp51 = 0.39312
    @Published var cp52 = 0.93522
    @Published var cp53 = 0.54238
    @Published var cp54 = 1.01787
    @Published var cp55 = 0.45911
    @Published var cp56 = 1.01312

    @Published var cp61 = 0.38948
    @Published var cp62 = 0.93091

    @Published var cp71 = 0.0689
    @Published var cp72 = 0.71361
    @Published var cp73 = 0.29219
    @Published var cp74 = 0.81604
    @Published var cp75 = 0.18284
    @Published var cp76 = 0.74193

    @Published var cp8 = 0.6965

    @Published var counter = 0

    var lastPosition: CGFloat = 0
    init(offset: CGFloat) {
        self.offset = offset
        update(offset: offset)
    }

    func update(offset: CGFloat) {
        let scrollUp: Bool = offset > self.offset
        self.offset = offset
        cp1 = adjustValueToHeight(value: cp1, scrollUp: scrollUp)

        cp21 = adjustValueToHeight(value: cp21, scrollUp: scrollUp)
        cp22 = adjustValueToHeight(value: cp22, scrollUp: scrollUp)

        cp31 = adjustValueToHeight(value: cp31, scrollUp: scrollUp)
        cp32 = adjustValueToHeight(value: cp32, scrollUp: scrollUp)
        cp33 = adjustValueToHeight(value: cp33, scrollUp: scrollUp)
        cp34 = adjustValueToHeight(value: cp34, scrollUp: scrollUp)
        cp35 = adjustValueToHeight(value: cp35, scrollUp: scrollUp)
        cp36 = adjustValueToHeight(value: cp36, scrollUp: scrollUp)

        cp41 = adjustValueToHeight(value: cp41, scrollUp: scrollUp)
        cp42 = adjustValueToHeight(value: cp42, scrollUp: scrollUp)

        cp51 = adjustValueToHeight(value: cp51, scrollUp: scrollUp)
        cp52 = adjustValueToHeight(value: cp52, scrollUp: scrollUp)
        cp53 = adjustValueToHeight(value: cp53, scrollUp: scrollUp)
        cp54 = adjustValueToHeight(value: cp54, scrollUp: scrollUp)
        cp55 = adjustValueToHeight(value: cp55, scrollUp: scrollUp)
        cp56 = adjustValueToHeight(value: cp56, scrollUp: scrollUp)

        cp61 = adjustValueToHeight(value: cp61, scrollUp: scrollUp)
        cp62 = adjustValueToHeight(value: cp62, scrollUp: scrollUp)

        cp71 = adjustValueToHeight(value: cp71, scrollUp: scrollUp)
        cp72 = adjustValueToHeight(value: cp72, scrollUp: scrollUp)
        cp73 = adjustValueToHeight(value: cp73, scrollUp: scrollUp)
        cp74 = adjustValueToHeight(value: cp74, scrollUp: scrollUp)
        cp75 = adjustValueToHeight(value: cp75, scrollUp: scrollUp)
        cp76 = adjustValueToHeight(value: cp76, scrollUp: scrollUp)

        cp8 = adjustValueToHeight(value: cp8, scrollUp: scrollUp)
    }

    func adjustValueToHeight(value: Double, scrollUp: Bool) -> Double {
        switch value {
        case 0.6...0.69:
            return rectangleHeight
        case let x where x < rectangleHeight:
            return scrollUp ? value + 0.01 : value - 0.01
        case let x where x > rectangleHeight:
            return scrollUp ? value - 0.01 : value + 0.01
        default:
            return rectangleHeight
        }
    }
}
