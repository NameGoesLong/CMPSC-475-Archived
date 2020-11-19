//
//  QRCodeView.swift
//  Tag
//
//  Created by New User on 19/11/20.
//

import SwiftUI
import Contacts
import CoreImage.CIFilterBuiltins

struct QRCodeView : View {
    @ObservedObject var record : Record
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View{
        Image(uiImage: generateQRCode(from: generateVCard(from: record)))
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
    
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
    
    func generateVCard(from record: Record) -> Data?{
        let contactItem = CNMutableContact()
        var result : Data? = nil
        contactItem.givenName = record.firstname
        contactItem.familyName = record.lastname
        contactItem.phoneNumbers = [CNLabeledValue(
                                        label: CNLabelPhoneNumberiPhone,
                                        value: CNPhoneNumber(stringValue: record.phone))]
        do {
            try result = CNContactVCardSerialization.data(with: [contactItem])
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return result
    }
    
}
