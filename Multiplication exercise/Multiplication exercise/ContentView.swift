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
            Spacer()
            TitleView()
            Spacer()
            MainView()
                .padding(.vertical)
            Spacer()
        }.frame( maxWidth: .infinity, maxHeight: .infinity).background(Color.yellow.opacity(0.4)).foregroundColor(Color.pink.opacity(0.6))
        
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
    let selection_arr : [Int] = [175, 179, 176, 181]
    var body: some View{
        VStack{
            ScoreView()
                .padding(.vertical)
            QuestView().padding(.top)
            ChoiceView(choices: self.selection_arr)
        }
    }
}


struct ScoreView: View {
    let correctCounter : Int = 1
    let score : [Int] = [1,2,0,0,0]
    var body: some View{
        VStack{
            HStack{
                ForEach(score, id: \.self){i in
                    IndicatorView(correctness: i)
                }.padding(2.0).background(Circle().fill(Color.gray).opacity(0.4))
            }
            .padding(.vertical)
            Text("\(correctCounter)/5")
                .padding(.vertical)
        }
        
    }
}

//View for showing the question
struct QuestView: View {
    let problemId : Int = 3
    let multiplicand : Int = 17
    let multiplier : Int = 8
    
    var body: some View{
        VStack{
            Text("Problem \(problemId)")
            VStack(alignment: .trailing){
                Text("\(multiplicand)")
                Text("X \(multiplier)")
            }.padding(.top).font(.largeTitle)
            Rectangle().frame(width: 100.0, height: 7.0)
        }
    }
}

//View for button selection
struct ChoiceView: View{
    let choices : [Int]
    var body: some View{
        HStack{
            ForEach(choices, id: \.self){ choice in
                Button("\(choice)"){}.padding(.all, 10.0).background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).opacity(0.5)).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .padding(.top)
        }
    }
}

//View for indication of correctness
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

//Not used in Homework1
struct JudgeView: View{
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
