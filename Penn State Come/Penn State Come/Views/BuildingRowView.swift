//
//  BuildingListRow.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

struct BuildingRowView : View {
    var building : Building
    var body: some View{
        HStack{
            Text(building.name)
            Image(systemName: "heart.fill")
                .foregroundColor(Color.secondary)
                .padding(.all,5.0)
                .opacity(building.favorite ? 0.8 : 0.0)
            Spacer()
                Image(building.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40, alignment: .center)
        }
    }
    
}
