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
    var exportHelper = ExportHelper()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let fuberBlue = Color("Fuber blue")
    
    var body: some View{
        VStack{
            HStack{
                Image("avator")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(5.0)
                    .background(
                        Circle()
                            .fill(Color.gray)
                            .opacity(0.1)
                    )
                    .frame( maxHeight: 80)
                    .padding(.horizontal)
                VStack(alignment:.leading){
                    Text(record.firstname + " " + record.lastname)
                    Text(record.position == "" ? "Position": record.position)
                        .italic()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(record.company == "" ? "Company": record.company)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
            }
            Image(uiImage: exportHelper.generateQRCode(from: exportHelper.generateVCard(from: record)))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .opacity(0.2)
                )
                .frame(width: 300, height: 300)
            Text("Scan the QR code to add to Contact list")
                .font(.subheadline)
                .padding(3)
        }
    }
    
//    func generateQRCode(from data: Data?) -> UIImage {
//        //TODO: might need to check if data is nil
//        filter.setValue(data, forKey: "inputMessage")
//
//        if let outputImage = filter.outputImage {
//            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgimg)
//            }
//        }
//
//        return UIImage(systemName: "xmark.circle") ?? UIImage()
//    }
//
//    func generateVCard(from record: Record) -> Data?{
//        let contactItem = CNMutableContact()
//        var result : Data? = nil
//        contactItem.givenName = record.firstname
//        contactItem.familyName = record.lastname
//        contactItem.phoneNumbers = [CNLabeledValue(
//                                        label: CNLabelPhoneNumberiPhone,
//                                        value: CNPhoneNumber(stringValue: record.phone))]
//        do {
//            try result = CNContactVCardSerialization.data(with: [contactItem])
//        } catch {
//            print("Unexpected error: \(error).")
//        }
//
//        return result
//    }
    
}
