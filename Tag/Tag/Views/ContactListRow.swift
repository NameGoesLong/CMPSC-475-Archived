//
//  ContactListRow.swift
//  Tag
//
//  Created by New User on 18/11/20.
//

import SwiftUI

struct ContactListRow : View {
    @ObservedObject var record :Record
    var body: some View{
        HStack{
            Image("avator")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(height: 40, alignment: .center)
            Text(record.firstname + " " + record.lastname)
            
        }
    }
    
}

