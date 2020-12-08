//
//  ContactDetailView.swift
//  Tag
//
//  Created by New User on 18/11/20.
//

import SwiftUI
import UIKit
import Contacts

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}


struct ContactDetailView: View {
    @ObservedObject var record : Record
    @State private var showingAlert = false
    @State private var showingQRCode = false
    @State var activeSheet: ActiveSheet?
    @State private var isPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack{
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
                    HStack{
                        Spacer()
                        // Be aware of the empty image storage
                        Image(uiImage: UIImage(data: record.cardImage)!)
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
            }
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    SaveToContacts(record: record)
                    showingAlert = true
                }){
                    Image(systemName: "square.and.arrow.up.on.square")
                }
                
            }
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    self.activeSheet = .second
                    print("Change")
                }){
                    Image(systemName: "square.and.pencil")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    self.activeSheet = .first
                }){
                    Image(systemName: "qrcode")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            ToolbarItem(placement: .bottomBar) {
                deleteButton
            }
        }
        //.navigationBarItems(trailing: deleteButton)
        .sheet(item: $activeSheet) {item in
            switch item {
            case .first:
                QRCodeView(record: record)
            case .second:
                Text("Change item")
            }
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
                Button(action: {
                    showingQRCode = true
                }){
                    Text("Generate QR Code")
                }.buttonStyle(ResultButtonStyle())
                .opacity(0.7)
            }
        }.padding(10.0)
    }
    
//    private var closeButton: some View {
//        Button(action: {
//            withAnimation {
//                self.isPresented.toggle()
//            }
//        }) {
//            Image(systemName: "xmark")
//                .padding(8)
//        }
//    }
    
    private var deleteButton : some View {
        Button(action: {
            //MARK: Exit the view here
            self.presentationMode.wrappedValue.dismiss()
            self.viewContext.delete(record)
        })
        {
            Image(systemName: "trash")
            
        }
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
