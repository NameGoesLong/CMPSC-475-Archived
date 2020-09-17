//
//  DefaultButtonStyle.swift
//  Multiplication exercise
//
//  Created by New User on 16/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import SwiftUI

// Button style presets
struct ResultButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding(.all).background(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct SelectionButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 32.0)
            .padding(10.0).background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray).opacity(0.2))
    }
}
