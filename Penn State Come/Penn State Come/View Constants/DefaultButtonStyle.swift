//
//  DefaultButtonStyle.swift
//  Penn State Come
//
//  Created by New User on 7/10/20.
//

import SwiftUI

// Button style presets
struct ResultButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding(.all)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.primary)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/))
    }
}

struct SelectionButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 32.0)
            .padding(10.0)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.gray).opacity(0.2))
    }
}

