//
//  MainView.swift
//  Tag
//
//  Created by New User on 8/11/20.
//

import Foundation
import SwiftUI

struct MainView : View{
    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View{
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        
                        Text("Tap button to start scanning.")
                            .padding()
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: ProcessItemView().environment(\.managedObjectContext, viewContext)) {
                        Text("Process new card")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.red))
                    Spacer()
                    NavigationLink(destination: ContactMainView().environment(\.managedObjectContext, viewContext)) {
                        Text("Card List")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                }
                .padding()
            }
            .navigationBarTitle("Text Recognition")
//            .sheet(isPresented: $showingScanningView) {
//                ScanDocumentView(recognizedText: self.$recognizedText)
//            }
        }
    }
}
