//
//  ContactDetailModifyView.swift
//  Tag
//
//  Created by New User on 9/12/20.
//

import SwiftUI

struct ContactDetailModifyView : View {
    @ObservedObject var record : Record
    @Binding var activeSheet: ActiveSheet?
    @Environment(\.managedObjectContext) private var viewContext

    @State var firstname : String = ""
    @State var lastname : String = ""
    @State var phone : String = ""
    @State var email : String = ""
    @State var company : String = ""
    @State var position : String = ""

    
    let fuberBlue = Color("Fuber blue")

    var body: some View{
        // The form to enable users to change the data for a record
        NavigationView{
            Form{
                Section(header: Text("Basic information")){
                    HStack{
                        Text("First name")
                            .padding(.trailing)
                        TextField("First name", text: $firstname)
                            .keyboardType(.namePhonePad)
                    }
                    HStack{
                        Text("Last name")
                            .padding(.trailing)
                        TextField("Last name", text: $lastname)
                            .keyboardType(.namePhonePad)
                    }
                    HStack{
                        Text("Phone number")
                            .padding(.trailing)
                        TextField("Phone number", text: $phone)
                            .keyboardType(.phonePad)
                    }
                }
                Section(header: Text("Additional information")){
                    HStack{
                        Text("Email")
                            .padding(.trailing)
                        TextField("Email address", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    HStack{
                        Text("Company")
                            .padding(.trailing)
                        TextField("Name of company", text: $company)
                    }
                    HStack{
                        Text("Position")
                            .padding(.trailing)
                        TextField("Title of position", text: $position)
                    }
                }
                Section{
                    HStack{
                        Spacer()
                        Button(action: {
                            changeRecord()
                            print("saved")
                            self.activeSheet = nil
                            }){
                            Text("Save")
                        }
                        Spacer()
                    }
                }
                Section{
                    HStack{
                        Spacer()
                        Button(action: {
                            print("quit")
                            self.activeSheet = nil
                            }){
                            Text("Discard")
                                .foregroundColor(Color.red)
                        }
                        Spacer()
                    }
                }
            }.onAppear(){
                firstname = record.firstname
                lastname = record.lastname
                phone = record.phone
                email = record.email
                company = record.company
                position = record.position
            }
            .navigationBarTitle("Change the record")
            .navigationBarColor(UIColor(fuberBlue))
        }
    }
    
    func changeRecord() {
        record.firstname = firstname
        record.lastname = lastname
        record.phone = phone
        record.email = email
        record.company = company
        record.position = position
    }
}
