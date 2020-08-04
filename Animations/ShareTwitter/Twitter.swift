//
//  Fluid.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 16/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct Twitter: View {
    
    @State var width: CGFloat
    @State var height: CGFloat
    @State var curveHeight: CGFloat = 0
    @State var curveLength: CGFloat
    @State var speed: Double
    @State var color: Color
    
    @State private var time: Double = 0
    @State private var offsetY = 0
    @State private var animate = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                ZStack {
                    Fluid(time: CGFloat(time*1.2), width: width, height: height, curveHeight: curveHeight, curveLength: curveLength)
                        .fill(color)
                        .frame(width: width, height: height)
                    Fluid(time: CGFloat(time), width: width, height: height, curveHeight: curveHeight, curveLength: curveLength)
                        .fill(color)
                        .opacity(0.5)
                        .frame(width: width, height: height)
                }
                .offset(x: 0, y: CGFloat(self.offsetY))
            }
            .mask(
                Image("twitter")
                    .resizable()
                    .frame(width: width, height: height)
            )
        }
        .onTapGesture {
            self.animate.toggle()
        }
        .onAppear {
            self.offsetY = Int((self.height/2) + self.curveHeight)
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                self.time += 0.01
                if self.offsetY >= (-Int((self.height/2) + self.curveHeight)) {
                    if self.animate {
                        withAnimation(Animation.linear(duration: 0.03)) {
                            self.offsetY -= 1
                        }
                    }
                }
            }
        }
    }
}

