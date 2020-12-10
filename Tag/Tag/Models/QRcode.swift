//
//  QRcode.swift
//  Tag
//
//  Created by New User on 9/12/20.
//

import SwiftUI
import UIKit
import CoreImage.CIFilterBuiltins

struct QRCode{
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    func generateQRCode(from data: Data?) -> UIImage {
        //TODO: might need to check if data is nil
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
