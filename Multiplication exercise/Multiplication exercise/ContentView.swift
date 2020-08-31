//
//  ContentView.swift
//  Multiplication exercise
//
//  Created by New User on 31/8/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center){
            TitleView().padding(.vertical)
            MainView()
                .padding(.vertical)
        }.frame( maxWidth: .infinity, maxHeight: .infinity).background(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TitleView: View {
    let title: String = "Multiplication Exercises"
    var body: some View{
        ZStack{
            Text(title).padding(5.0).background(RoundedRectangle(cornerRadius: 50).fill(Color.gray).opacity(0.2))
        }
    }
}

struct MainView: View {
    var body: some View{
        VStack{
            ScoreView()
                .padding(.vertical)
            QuestView().padding(.vertical)
        }
    }
}


struct ScoreView: View {
    let correctCounter : Int = 2
    var body: some View{
        VStack{
            HStack{
                ForEach(1..<6){i in
                    IndicatorView(correctness: i)
                }.padding(2.0).background(Circle().fill(Color.gray).opacity(0.4))
            }
            .padding(.vertical)
            Text("\(correctCounter)/5")
                .padding(.vertical)
        }
        
    }
}

struct QuestView: View {
    let problemId : Int = 3
    let multiplicand : Int
    let multiplier : Int
    let result : Int
    
    init(){
        multiplicand = Int.random(in: 1...15)
        multiplier = Int.random(in: 1...15)
        result = multiplier * multiplicand
    }
    
    var body: some View{
        VStack{
            Text("Problem \(problemId)")
            VStack(alignment: .trailing){
                Text("\(multiplicand)")
                Text("X \(multiplier)")
            }.padding(.top).font(.largeTitle)
            Rectangle().frame(width: 100.0, height: 7.0)
            HStack{
                ForEach(1..<5){i in
                    Button("\(self.result + i - 1)"){}
                }.padding(.all, 10.0).background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).opacity(0.5))
            }.padding(.all)
        }
    }
}

struct IndicatorView: View {
    let correctness: Int
    var body: some View{
        VStack{
            if(correctness == 1){
                Text("✔️")
            }else if(correctness == 2){
                Text("❌")
            }else{
                Text("      ")
            }
        }
    }
}

struct JugdgeView: View{
    let result : Int
    var body: some View{
        VStack{
            if(result == 1){
                Text("Correct!")
            }else{
                Text("Wrong!")
            }
            Button("Next question"){}
        }
    }
}
