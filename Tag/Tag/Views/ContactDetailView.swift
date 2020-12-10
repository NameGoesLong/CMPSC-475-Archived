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
    //@State private var showingQRCode = false
    @State var activeSheet: ActiveSheet?
    //@State private var isPresented = false
    @State var isShareSheetShowing = false
    @State var infoSection : InfoPage = .info
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    private var QRcodeHelper = QRCode()
    let fuberBlue = Color("Fuber blue")

    
    init(record : Record) {
        self.record = record
        UIToolbar.appearance().barTintColor = UIColor(fuberBlue)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIToolbar.self]).tintColor = UIColor(Color.white)
    }
        
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
                Spacer()
                Button(action: {
                    print("alert")
                    self.showingAlert = true
                }){
                    Image(systemName: "square.and.arrow.down.on.square")
                    
                }.padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Do you want to export this TAG to the Contact app?"),
                          message: Text("The TAG of \(record.firstname) \(record.lastname) will be added to your Contact app after confirmation."),
                          primaryButton: .default(Text("Confirm")) {
                            print("Adding to Contact...")
                            SaveToContacts(record: record)
                            self.showingAlert = false
                          },
                          secondaryButton: .cancel(){
                            self.showingAlert = false
                          }
                    )
                }
            }
            VStack{
                Picker("selection", selection: $infoSection/*@START_MENU_TOKEN@*//*@END_MENU_TOKEN@*/){
                    Text("Basic Info").tag(InfoPage.info)
                    Text("Card Image").tag(InfoPage.card)
                    //Text("Other Info").tag(InfoPage.other)
                }.padding(.horizontal).pickerStyle(SegmentedPickerStyle())
            }
            Group{
                ContactDetailInfoView(record: record, infoSection: $infoSection)
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Button(action: {
                    print("Added")
                    shareButton()
                    //SaveToContacts(record: record)
                    //showingAlert = true
                }){
                    Image(systemName: "square.and.arrow.up.on.square")
                    
                }
                Spacer()
                Button(action: {
                    self.activeSheet = .second
                    print("Change")
                }){
                    Image(systemName: "square.and.pencil")
                }
                Spacer()
                Button(action: {
                    self.activeSheet = .first
                }){
                    Image(systemName: "qrcode")
                }
                Spacer()
                deleteButton
                
            }
        }
        .navigationBarColor(UIColor(fuberBlue))
        .navigationBarTitle(Text(record.firstname + " " + record.lastname))
        .sheet(item: $activeSheet) {item in
            switch item {
            case .first:
                QRCodeView(record: record)
            case .second:
                ContactDetailModifyView(record: record, activeSheet: $activeSheet)
            }
        }
    }
    
    
    
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
    
    func shareButton(){
        isShareSheetShowing.toggle()
        let description = "Hey, someone has shared the tag of \(record.firstname) \(record.lastname) to you. Scan the QR code to store in the the contact."
        let qrcode = QRcodeHelper.generateQRCode(from: generateVCard(from: record))
        let av = UIActivityViewController(activityItems: [qrcode, description], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
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
