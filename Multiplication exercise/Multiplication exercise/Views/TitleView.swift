//
//  TitleView.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    let title: String = "Multiplication Exercises"
    var body: some View{
        ZStack{
            Text(title).padding(5.0).background(RoundedRectangle(cornerRadius: 50).fill(Color.gray).opacity(0.2))
        }
    }
}
