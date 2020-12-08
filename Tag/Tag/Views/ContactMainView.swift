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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View{
        NavigationView {
            VStack{
                VStack{
                    SearchBar(text: $searchText, filteringRequirement: $filteringRequirement)
                    ContactListView(searchPredicate: searchFilter()).environment(\.managedObjectContext, viewContext)
                }
                .environment(\.managedObjectContext, viewContext)
                .padding()
            }
            .navigationBarTitle("TAG", displayMode: .inline)
            .navigationBarItems(trailing:
                                    NavigationLink(
                                        destination: ProcessItemView().environment(\.managedObjectContext, viewContext)
                                    ) {
                                        Image(systemName: "camera.fill")
                                    }
            )
        }
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
