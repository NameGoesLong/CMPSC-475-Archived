//
//  ContactMainView.swift
//  Tag
//
//  Created by New User on 30/11/20.
//

import SwiftUI

struct ContactMainView : View{
    @State var searchText = ""
    @State var filteringRequirement = "first"
    @State var openScanView : Int? = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    let fuberBlue = Color("Fuber blue")
    
    var body: some View{
        NavigationView {
            VStack{
                VStack{
                    SearchBar(text: $searchText, filteringRequirement: $filteringRequirement)
                    ContactListView(searchPredicate: searchFilter()).environment(\.managedObjectContext, viewContext)
                        .overlay(scanButton,alignment: .bottomTrailing)
                }
                .environment(\.managedObjectContext, viewContext)
                .padding()
                NavigationLink(
                    destination: ProcessItemView().environment(\.managedObjectContext, viewContext)
                    ,tag:1, selection:$openScanView) {
                    EmptyView()
                }
            }
            .navigationBarTitle("TAG", displayMode: .inline)
            .navigationBarColor(UIColor(fuberBlue))
        }
    }
    
    var scanButton : some View{
        Button(action: {
                print("clicked")
            self.openScanView = 1
        }) {
            Image(systemName: "camera.circle.fill").resizable()
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(fuberBlue)
        }.padding(.horizontal, 20.0)
        .background(Circle().fill(Color.white))
    }
    
    func searchFilter() ->  (NSCompoundPredicate?){
        let trimmedText = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText == "" {
            return nil
        }else{
            let words = searchText.components(separatedBy: " ")
            
            var predicateArr = [NSPredicate]()
            for word in words {
                    let predicate = NSPredicate(format: "(firstname contains [cd] %@) OR (lastname contains [cd] %@)", word, word)
                    predicateArr.append(predicate)
            }
            
            
            let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
            return compound
        }
    }
    

}
