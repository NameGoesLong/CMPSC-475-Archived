//
//  ContentView.swift
//  PokemonHelper
//
//  Created by New User on 20/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pokedex : Pokedex
    @State var showingPreferences = false
    var body: some View {
        // Show all the rows in the Categories view
        NavigationView{
            List{
                Categories().environmentObject(pokedex)
            }.navigationBarTitle(Text("Pokédex"))
            .navigationBarItems(trailing: NavigationLink(destination: PokemonListView().environmentObject(pokedex)) {
                                    Image(systemName: "slider.horizontal.3")
                                        .imageScale(.large)
                                        .accessibility(label: Text("Setting"))
                                        .padding()})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
