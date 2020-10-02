//
//  ContentView.swift
//  PokemonHelper
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var pokedex = Pokedex()
    @State var showingPreferences = false
    //@State var sectionStyle : SectionStyle = .none
    var body: some View {
        //PokemonListView()
        NavigationView{
            List{
                Categories(pokedex: $pokedex)
            }.navigationBarTitle(Text("Pokédex"))
            .navigationBarItems(trailing: NavigationLink(destination: PokemonListView(pokedex: $pokedex)) {
                                    Image(systemName: "slider.horizontal.3")
                                    .imageScale(.large)
                                    .accessibility(label: Text("Setting"))
                                    .padding()})
                
            
        }
    }
    
    var preferenceButton: some View {
        Button(action: { self.showingPreferences.toggle() }) {
            Image(systemName: "slider.horizontal.3")
                .imageScale(.large)
                .accessibility(label: Text("Setting"))
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
