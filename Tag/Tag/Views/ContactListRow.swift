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
                Text(record.position == "" ? "Position": record.position)
                    .italic()
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text(record.company == "" ? "Company": record.company)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
        }
    }
    
}

