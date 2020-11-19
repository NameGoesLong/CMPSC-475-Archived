//
//  ProcessItemView.swift
//  Tag
//
//  Created by New User on 14/11/20.
//

import SwiftUI

enum processPhase :String, CaseIterable{
    case scan = "Scan Item"
    case getName = "Get Name"
    case getPhone = "Get Phone Number"
    case summary = "Record Summary"
}

struct ProcessItemView : View {
    
    @State private var recognizedText : [String] = []
    @State private var showingScanningView = false
    @State private var afterScan = false
    @ObservedObject private var record = RecordChecker()
    
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Record>
    private var records: FetchedResults<Record> {fetchRequest.wrappedValue}
    
    init(){
        fetchRequest = FetchRequest<Record>(
            entity: Record.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Record.lastname, ascending: true)],
            animation: .default
        )
    }
    
    var body: some View{
        Group{
            VStack {
                //Group{
                    if !recognizedText.isEmpty{
                        Form{
                            Section{
                                Picker(selection: $record.name, label: Text("Choose data for Name")) {
                                    Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                    ForEach(recognizedText,id:\.self){ element in
                                        Text(element)
                                    }
                                }.pickerStyle(DefaultPickerStyle())
                                Picker(selection: $record.phone, label: Text("Choose data for Phone")) {
                                    Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                    ForEach(recognizedText,id:\.self){ element in
                                        Text(element)
                                    }
                                }.pickerStyle(DefaultPickerStyle())
                            }
                        }
                        
                        TextField("Name", text:$record.name).disabled(record.name=="")
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.namePhonePad)
                        Validator(icon: record.isNameValid ?
                                    "checkmark.rectangle.fill"
                                    : "xmark.square",
                                  color: record.isNameValid ?
                                    Color.green
                                    : Color.red,
                                  message: record.isNameValid ?
                                  "Valid name"
                                  : "Invalid name. Correct format: \"<Firstname> <LastName>\"")
                        
                        TextField("Phone", text:$record.phone).disabled(record.phone=="")
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                        Validator(icon: record.isPhoneValid ?
                                    "checkmark.rectangle.fill"
                                    : "xmark.square",
                                  color: record.isPhoneValid ?
                                    Color.green
                                    : Color.red,
                                  message: record.isPhoneValid ?
                                  "Valid name"
                                  : "Invalid phone.")
                    }
                    
                //}
                
                Spacer()
                buttonGroup
            }
        }.sheet(isPresented: $showingScanningView) {
            ScanDocumentView(recognizedText: self.$recognizedText, scanSuccess: self.$afterScan)
        }
    }
    
    var buttonGroup: some View {
        HStack {
            if !afterScan{
                Button(action: {
                    // start scanning
                    self.showingScanningView = true
                }) {
                    Text("Start Scanning")
                }
                .padding()
                .foregroundColor(.white)
                .background(Capsule().fill(Color.blue))
            }else{
                Button(action: {
                    // start scanning
                    addRecord(name: record.name, phone: record.phone)
                    print("record added")
                }) {
                    Text("Add to record")
                }
                .disabled(!(record.isNameValid && record.isPhoneValid))
                .padding()
                .foregroundColor(.white)
                .background(
                    Capsule()
                        .fill(
                            record.isNameValid && record.isPhoneValid ?
                                Color.blue
                                : Color.gray
                        )
                )
            }
        }
    }
    
    func addRecord(name: String, phone: String){
        let newRecord = Record(context: viewContext)
        newRecord.phone = phone
        let nameSet = name.components(separatedBy: " ")
        newRecord.firstname = nameSet[0]
        newRecord.lastname = nameSet[1]
    }
}

struct Validator : View {
    var icon : String
    var color : Color
    var message : String
    
    var body: some View{
        HStack{
            Image(systemName: icon)
                .foregroundColor(color)
            Text(message)
                .foregroundColor(color)
        }
    }
}
