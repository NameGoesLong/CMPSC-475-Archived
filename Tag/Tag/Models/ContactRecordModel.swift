//
//  ContactRecordModel.swift
//  Tag
//
//  Created by New User on 14/11/20.
//
//  Extracted from:https://www.youtube.com/watch?v=0v9lDOrOEM0

import Foundation
import Combine

// The class handles the verification for record data. We only check for the correctness for name and phone number
class RecordChecker : ObservableObject{
    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var position = ""
    @Published var company = ""
    
    @Published var isNameValid = false
    @Published var isPhoneValid = false
    
    // use regex to check if the phone number is correct
    // Extracted from: https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number
    let regex = NSRegularExpression("^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]\\d{3}[\\s.-]\\d{4}$")

    
    private var cancellableSet : Set<AnyCancellable> = []
    
    init(){
        $name
            .receive(on: RunLoop.main)
            .map{
                name in
                return name.split(separator: " ").count == 2
            }.assign(to: \.isNameValid, on: self)
            .store(in: &cancellableSet)
        
        $phone
            .receive(on: RunLoop.main)
            .map{
                phone in
                return self.regex.matches(phone)
            }.assign(to: \.isPhoneValid, on: self)
            .store(in: &cancellableSet)
    }
    
}
