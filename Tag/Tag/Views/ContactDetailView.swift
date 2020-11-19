//
//  ContactDetailView.swift
//  Tag
//
//  Created by New User on 18/11/20.
//

import SwiftUI
import UIKit
import Contacts


struct ContactDetailView: View {
    @ObservedObject var record : Record
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) private var viewContext


    var body: some View{
        List{
            HStack{
                Spacer()
                Image("avator")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5.0)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray)
                            .opacity(0.1)
                    )
                    .frame( maxHeight: 160)
                Spacer()
            }
            
            VStack(alignment:.leading){
                Text("First Name: \(record.firstname)")
                    .padding(1)
                Text("Last Name: \(record.lastname)")
                    .padding(1)
                Text("Phone Number: \(record.phone)")
                    .padding(1)
            }.font(.subheadline)
            
            buttonGroupView
            
        }
    }
    
    var buttonGroupView : some View{
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    SaveToContacts(record: record)
                    showingAlert = true
                }){
                    Text("Export to Contacts")
                }.buttonStyle(ResultButtonStyle())
                .opacity(0.7)
                .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Important message"), message: Text("Successfully stored into the Contacts."), dismissButton: .default(Text("Got it!")))
                        }
                Spacer()
            }
        }.padding(10.0)
    }
    
    func SaveToContacts(record : Record){
        // Create a mutable object to add to the contact
        let contact = CNMutableContact()
        
        // Store the profile picture as data
        let image = UIImage(systemName: "avator")
        contact.imageData = image?.jpegData(compressionQuality: 1.0)
        
        contact.givenName = record.firstname
        contact.familyName = record.lastname
        
        //        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "john@example.com" as NSString)
        //        let workEmail = CNLabeledValue(label: CNLabelWork, value: "j.appleseed@icloud.com" as NSString)
        //        contact.emailAddresses = [homeEmail, workEmail]
        
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
        
        // Save the newly created contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error
        }
    }
}