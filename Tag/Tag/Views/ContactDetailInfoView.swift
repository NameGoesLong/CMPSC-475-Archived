//
//  ContactDetailInfoView.swift
//  Tag
//
//  Created by New User on 8/12/20.
//

import SwiftUI

enum InfoPage: String, Equatable {
    case info = "info"
    case card = "card"
    case other = "other"
    
}

struct ContactDetailInfoView : View {
    @ObservedObject var record : Record
    @Binding var infoSection : InfoPage
    
    
    @State var username: String = ""
        
        var body: some View {
            List{
                showCorrespondingView ()
            }.listStyle(PlainListStyle())
        }
    
    var infoPage : some View{
        Group{
            Section(header: Text("Telephone")) {
                HStack{
                    Text("Mobile").bold()
                        .padding(.horizontal)
                    Spacer()
                    // Use link to initiate the apps -- https://stackoverflow.com/a/63716406
                    Link(record.phone, destination: URL(string: "tel:\(record.phone)")!)
                }
            }
            if record.email != ""{
                Section(header: Text("Email")) {
                    HStack{
                        Text("Work").bold()
                            .padding(.horizontal)
                        Spacer()
                        Link(record.email, destination: URL(string: "mailto:\(record.email)")!)
                    }
                }
            }
        }
    }
    
    var cardPage : some View{
        HStack{
            Spacer()
            // Be aware of the empty image storage
            Image(uiImage: UIImage(data: record.cardImage)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5.0)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .opacity(0.1)
                )
                .frame( maxHeight: 160)
            Spacer()
        }
    }
    
    var otherPage : some View{
        VStack{
            Text("other page")
            Text("other page")
            Text("other page")
            Text("other page")
            Text("other page")

        }
    }
    
    func showCorrespondingView () -> AnyView{
        switch self.infoSection{
        case .info:
            return AnyView(infoPage)
        case .card:
            return AnyView(cardPage)
        case .other:
            return AnyView(otherPage)
        }
    }
}
