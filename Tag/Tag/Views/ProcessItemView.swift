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
    
    let fuberBlue = Color("Fuber blue")
    
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
                // show only when there is a picture being processed
                if !recognizedText.isEmpty{
                    // Scanned card
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
                    // Section for name. Show the picker View before selection(empty entry), show the text view after selection
                    Form{
                        Section(header:
                                    Text("Mandatory information: name"),
                                footer:
                                    //The validator for name
                                    Validator(icon: record.isNameValid ?
                                                "checkmark.rectangle.fill"
                                                : "xmark.square",
                                              color: record.isNameValid ?
                                                Color.green
                                                : Color.red,
                                              message: record.isNameValid ?
                                                "Valid name"
                                                : "Invalid name. Correct format: \"<Firstname> <LastName>\"")
                        ){
                            if record.name == ""{
                                VStack{
                                    // List of data for picking
                                    Picker(selection: $record.name, label: Text("Choose data for Name")) {
                                        Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                        ForEach(recognizedText,id:\.self){ element in
                                            Text(element)
                                        }
                                    }.pickerStyle(DefaultPickerStyle())
                                }
                            }else{
                                // textbox for correction
                                HStack{
                                    Text("Name").padding(.trailing)
                                    TextField("Name", text:$record.name).disabled(record.name=="")
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.namePhonePad)
                                }
                            }

                            
                        }
                        // Section for phone. Show the picker View before selection(empty entry), show the text view after selection
                        Section(header:Text("Mandatory information: phone"),
                                footer:
                                    Validator(icon: record.isPhoneValid ?
                                                "checkmark.rectangle.fill"
                                                : "xmark.square",
                                              color: record.isPhoneValid ?
                                                Color.green
                                                : Color.red,
                                              message: record.isPhoneValid ?
                                                "Valid phone"
                                                : "Invalid phone.")
                        ){
                            if record.phone == ""{
                                VStack{
                                    //The validator for name
                                    Picker(selection: $record.phone, label: Text("Choose data for Phone")) {
                                        Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                        ForEach(recognizedText,id:\.self){ element in
                                            Text(element)
                                        }
                                    }.pickerStyle(DefaultPickerStyle())
                                }
                            }else{
                                // textbox for correction
                                HStack{
                                    Text("Phone").padding(.trailing)
                                    TextField("Phone", text:$record.phone).disabled(record.phone=="")
                                        .keyboardType(.phonePad)
                                }
                            }
                        }
                        Section(header:Text("Optional information: email")
                        ){
                            if record.email == ""{
                                VStack{
                                    Picker(selection: $record.email, label: Text("Choose data for Email")) {
                                        Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                        ForEach(recognizedText,id:\.self){ element in
                                            Text(element)
                                        }
                                    }.pickerStyle(DefaultPickerStyle())
                                }
                            }else{
                                HStack{
                                    Text("Email").padding(.trailing)
                                    TextField("Email", text:$record.email).disabled(record.email=="")
                                        .keyboardType(.emailAddress)
                                }
                            }
                        }
                        
                        Section(header:Text("Optional information: company")){
                            if record.company == ""{
                                VStack{
                                    Picker(selection: $record.company, label: Text("Choose data for Company")) {
                                        Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                        ForEach(recognizedText,id:\.self){ element in
                                            Text(element)
                                        }
                                    }.pickerStyle(DefaultPickerStyle())
                                }
                            }else{
                                HStack{
                                    Text("Company").padding(.trailing)
                                    TextField("Company", text:$record.company).disabled(record.company=="")
                                }
                            }
                        }
                        
                        Section(header:Text("Optional information: position")){
                            if record.position == ""{
                                VStack{
                                    Picker(selection: $record.position, label: Text("Choose data for Position")) {
                                        Text("-- PLEASE CHOOSE FROM INPUTS--").tag("")
                                        ForEach(recognizedText,id:\.self){ element in
                                            Text(element)
                                        }
                                    }.pickerStyle(DefaultPickerStyle())
                                }
                            }else{
                                HStack{
                                    Text("Position").padding(.trailing)
                                    TextField("Position", text:$record.position).disabled(record.position=="")
                                }
                            }
                        }
                    }
                }
                Spacer()
                buttonGroup
            }
        }
        .navigationBarColor(UIColor(fuberBlue))
        .sheet(isPresented: $showingScanningView) {
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
                    // add the record to the Core Data
                    addRecord(cardImage: scannedPicture, name: record.name, phone: record.phone, email: record.email, company: record.company, position: record.position)
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
    
    func addRecord(cardImage: CGImage?, name: String, phone: String, email: String, company: String, position: String){
        let newRecord = Record(context: viewContext)
        if cardImage != nil {
            let image = UIImage(cgImage: cardImage!)
            if let data = image.pngData() {
                newRecord.cardImage = data
            }
        }
        newRecord.phone = phone
        let nameSet = name.components(separatedBy: " ")
        newRecord.firstname = nameSet[0]
        newRecord.lastname = nameSet[1]
        newRecord.email = email
        newRecord.company = company
        newRecord.position = position
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
