//
//  BuildingListView.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import SwiftUI

enum SectionStyle: String, CaseIterable {
    case none, byName
}

struct BuildingListView : View {
    //@ State var campusBuildings = CampusBuildings()
    @EnvironmentObject var locationsManager : LocationsManager
    @Binding var tabSelection : Int
    var sectionStyle = SectionStyle.byName
    
    var body: some View{
        NavigationView{
            List{
                ForEach( sectionTitles(for: sectionStyle), id: \.self) { sectionTitle in
                    Section(header: Text(sectionTitle)) {
                        SectionViews(tabSelection: $tabSelection,
                                     filter: sectionFilter(for: sectionStyle, sectionTitle: sectionTitle))
                            .environmentObject(locationsManager)
                    }
                }
            }.navigationTitle("Penn State Buildings")
        }
        
    }
    
    // These functions are left for future extension
    // generate array of section titles based on section style
    func sectionTitles(for sectionStyle:SectionStyle) -> [String] {
        switch sectionStyle {
        case .byName:
            return locationsManager.campusBuildings.buildingTitles(using: {$0.name.firstLetter!})
        //case .byDecade: break
        default:
            assert(false, "No section titles for .none option")
        }
    }
    
    // generate a filter (predicate function) that tests whether a state belongs in the section with title sectionTitle using sectionStyle (by Name or by Decade)
    func sectionFilter(for sectionStyle:SectionStyle, sectionTitle:String) ->  ((Building) -> Bool) {
        switch sectionStyle {
        case .byName:
            return {$0.name.firstLetter! == sectionTitle}
        //case .byDecade:
        //     break
        default:
            assert(false, "No section filtering for .none option")
        }
    }
}

//struct BuildingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingListView(, tabSelection: <#Binding<Int>#>)
//    }
//}
