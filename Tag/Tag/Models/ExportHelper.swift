//
//  QRcode.swift
//  Tag
//
//  Created by New User on 9/12/20.
//

//import SwiftUI
import UIKit
import Contacts
import CoreImage.CIFilterBuiltins


// This part handles all the actions for exporting.
// Including showing QRcode, saving file to Contacts, and sharing the information to other users
struct ExportHelper{
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
    
    func constructMutableContact(record : Record) -> CNMutableContact{
        // Create a mutable object to add to the contact
        let contact = CNMutableContact()
        
        // Store the profile picture as data
        let image = UIImage(systemName: "avator")
        contact.imageData = image?.jpegData(compressionQuality: 1.0)
        
        contact.givenName = record.firstname
        contact.familyName = record.lastname
        
        if record.email != ""{
            let workEmail = CNLabeledValue(label: CNLabelWork, value: record.email as NSString)
            contact.emailAddresses = [workEmail]
        }
        if record.company != ""{
            contact.organizationName = record.company
        }
        if record.position != ""{
            contact.jobTitle = record.position
        }
        
        contact.phoneNumbers = [CNLabeledValue(
                                    label: CNLabelPhoneNumberiPhone,
                                    value: CNPhoneNumber(stringValue: record.phone))]
        
        //        let homeAddress = CNMutablePostalAddress()
        //        homeAddress.street = "One Apple Park Way"
        //        homeAddress.city = "Cupertino"
        //        homeAddress.state = "CA"
        //        homeAddress.postalCode = "95014"
        //        contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]
        
        //        var birthday = DateComponents()
        //        birthday.day = 1
        //        birthday.month = 4
        //        birthday.year = 1988  // (Optional) Omit the year value for a yearless birthday
        //        contact.birthday = birthday
        
        return contact
    }
    
    func generateVCard(from record: Record) -> Data?{
        var result : Data? = nil
        let contactItem = constructMutableContact(record: record)
        do {
            try result = CNContactVCardSerialization.data(with: [contactItem])
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return result
    }
    
    // clearing cache. https://stackoverflow.com/q/39004124
    public func clearCache(){
        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                    }
                    catch let error as NSError {
                        debugPrint("Ooops! Something went wrong: \(error)")
                    }

                }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
