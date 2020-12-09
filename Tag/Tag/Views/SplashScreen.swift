//
//  SplashScreen.swift
//  Tag
//
//  Created by New User on 8/12/20.
//

import SwiftUI

struct SplashScreen: View {
    let fuberBlue = Color("Fuber blue")
    @State var offset : CGFloat = -500.0
    @State var appear = 0.0
    
    var body: some View {
        ZStack {
            VStack{
                Image("mainIcon")
                    .resizable()
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                    .offset(y:offset)
                    .onAppear(){
                        let baseAnimation = Animation
                            .spring(response: 0.8, dampingFraction: 0.65, blendDuration: 0.3)
                            .speed(1)
                            .delay(2)
                                        return withAnimation(baseAnimation) {
                                            self.offset = 0
                                        }
                    }

                    Text("T A G")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(appear)
                        .onAppear(){
                            return withAnimation(Animation.easeInOut(duration: 1).delay(0.7)) {
                                self.appear = 1.0
                            }
                        }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                .background(fuberBlue)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
