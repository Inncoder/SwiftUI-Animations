//
//  Reddit.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 21/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct Reddit: View {
    
    @State var width: CGFloat
    @State var height: CGFloat
    @State var curveHeight: CGFloat = 0
    @State var curveLength: CGFloat
    @State var speed: Double
    @State var color: LinearGradient
    
    @State private var time: Double = 0
    @State private var offsetY = 0
    @State private var animate = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                ZStack {
                    Fluid(time: CGFloat(time*1.2), width: width+5, height: height, curveHeight: curveHeight, curveLength: curveLength)
                        .fill(color)
                        .frame(width: width, height: height)
                    Fluid(time: CGFloat(time), width: width+5, height: height, curveHeight: curveHeight, curveLength: curveLength)
                        .fill(color)
                        .opacity(0.5)
                        .frame(width: width, height: height)
                }
                .offset(x: 0, y: CGFloat(self.offsetY))
            }
            .mask(
                Image("reddit")
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

struct Fluid: Shape {
    var time: CGFloat
    let width: CGFloat
    let height: CGFloat
    let curveHeight: CGFloat
    let curveLength: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return (
            Path { path in
                path.move(to: CGPoint(x: width, y: height*2))
                path.addLine(to: CGPoint(x: 0, y: height*2))
                for i in stride(from: 0, to: CGFloat(rect.width), by: 1) {
                    path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + time) * curveLength * .pi) * curveHeight + rect.midY))
                }
                path.addLine(to: CGPoint(x: width, y: height*2))
            }
        )
    }
}







