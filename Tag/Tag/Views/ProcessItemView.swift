//
//  ProcessItemView.swift
//  Tag
//
//  Created by New User on 14/11/20.
//

import SwiftUI


struct ProcessItemView : View {
    
    @State private var recognizedText : [String] = []
    @State private var showingScanningView = true
    @State private var afterScan = false
    @State private var scannedPicture : CGImage? = nil
    @ObservedObject private var record = RecordChecker()
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

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
                        Image(decorative: scannedPicture!, scale: 1.0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(5.0)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray)
                                    .opacity(0.1)
                            )
                            .frame( maxHeight: 160)
                        Form{
                            Section(header:Text("Step 1: Choose the data from Scanned text")){
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
                            Section(header:Text("Step 2: Fix minor issues in the data")){
                                VStack{
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
                                }
                                VStack{
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
                            }
                        }
                    }
                Spacer()
                buttonGroup
            }
        }.sheet(isPresented: $showingScanningView) {
            ScanDocumentView(recognizedText: self.$recognizedText, scanSuccess: self.$afterScan, scannedPicture: $scannedPicture)
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
                    addRecord(name: record.name, phone: record.phone, cardImage: scannedPicture)
                    print("record added")
                    //MARK: Exit the view here
                    self.presentationMode.wrappedValue.dismiss()
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
    
    func addRecord(name: String, phone: String, cardImage: CGImage?){
        let newRecord = Record(context: viewContext)
        newRecord.phone = phone
        let nameSet = name.components(separatedBy: " ")
        newRecord.firstname = nameSet[0]
        newRecord.lastname = nameSet[1]
        if cardImage != nil {
            let image = UIImage(cgImage: cardImage!)
            if let data = image.pngData() {
                newRecord.cardImage = data
            }
        }
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
