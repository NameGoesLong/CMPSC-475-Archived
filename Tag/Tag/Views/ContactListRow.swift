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
            Image(uiImage: UIImage(data: record.cardImage)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60, alignment: .center)
            VStack(alignment:.leading){
                Text(record.firstname + " " + record.lastname)
                Text("Position")
                    .italic()
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text("Company")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
        }
    }
    
}

