//
//  QRCodeGenerator.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 17/03/2024.
//

import CoreImage.CIFilterBuiltins
import Solana
import SwiftUI

fileprivate let context = CIContext()
fileprivate let filter = CIFilter.qrCodeGenerator()

func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)

    if let outputImage = filter.outputImage {
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}

extension PublicKey {
    func generateQRCode() -> UIImage {
        Lego.generateQRCode(from: self.base58EncodedString)
    }
}
