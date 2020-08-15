//
//  DNALoading.swift
//  InstagramAnimation
//
//  Created by InnAppsCoding on 14/08/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

let firstC = Color(UIColor(red: 0.57, green: 0.92, blue: 0.94, alpha: 1.00))
let secondC = Color(UIColor(red: 0.50, green: 0.50, blue: 0.87, alpha: 1.00))
let firstC1 = Color(UIColor(red: 0.92, green: 0.69, blue: 0.81, alpha: 1.00))
let secondC2 = Color(UIColor(red: 0.40, green: 0.31, blue: 0.69, alpha: 1.00))

struct DNALoading: View {
    
    @State private var top: Bool = false
    
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(0..<self.numberOfBalls, id: \.self) { i in
                DNABalls(delay: (Double(i)/4),
                         ballSpeed: self.ballSpeed,
                         ballSize: self.ballSize,
                         firstBallColor: self.firstBallColor,
                         secondBallColor: self.secondBallColor)
                    .frame(width: self.ballSize, height: self.frameHeight)
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: self.ballSpeed, repeats: true) { _ in
                self.top.toggle()
            }
        }
    }
    
    // MARK: - Drawing Constents
    let numberOfBalls: Int = 5
    let spacing: CGFloat = 20
    let ballSpeed: Double = 0.75
    let ballSize: CGFloat = 30
    let frameHeight: CGFloat = 60
    let firstBallColor: LinearGradient = LinearGradient(gradient: Gradient(colors: [firstC, secondC]), startPoint: .top, endPoint: .bottom)
    let secondBallColor: LinearGradient = LinearGradient(gradient: Gradient(colors: [firstC1, secondC2]), startPoint: .top, endPoint: .bottom)
    
}
struct DNALoading_Previews: PreviewProvider {
    static var previews: some View {
        DNALoading()
    }
}

struct DNABalls: View {
    @State var delay: Double
    @State var ballSpeed: Double
    @State var ballSize: CGFloat
    @State var firstBallColor: LinearGradient
    @State var secondBallColor: LinearGradient
    
    @State private var top = false
    
    var body: some View {
        GeometryReader() { geo in
            ZStack {
                ZStack {
                    DNABall(delay: 0 + self.delay, ballSpeed: self.ballSpeed, ballSize: self.ballSize, rect: geo.size, color: self.firstBallColor)
                    DNABall(delay: self.ballSpeed + self.delay, ballSpeed: self.ballSpeed, ballSize: self.ballSize, rect: geo.size, color: self.secondBallColor)
                }
                .opacity(self.top ? 1 : 0)
                ZStack {
                    DNABall(delay: self.ballSpeed + self.delay, ballSpeed: self.ballSpeed, ballSize: self.ballSize, rect: geo.size, color: self.secondBallColor)
                    DNABall(delay: 0 + self.delay, ballSpeed: self.ballSpeed, ballSize: self.ballSize, rect: geo.size, color: self.firstBallColor)
                }
                .opacity(self.top ? 0 : 1)
            }
        }
        .onAppear() {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                Timer.scheduledTimer(withTimeInterval: self.ballSpeed, repeats: true) { _ in
                    self.top.toggle()
                }
            }
        }
    }
}
struct DNABalls_Previews: PreviewProvider {
    static var previews: some View {
        DNABalls(delay: 0,
                 ballSpeed: 1,
                 ballSize: 30,
                 firstBallColor: LinearGradient(gradient: Gradient(colors: [firstC, secondC]), startPoint: .top, endPoint: .bottom),
                 secondBallColor: LinearGradient(gradient: Gradient(colors: [firstC1, secondC2]), startPoint: .top, endPoint: .bottom)
        )
            .frame(width: 30, height: 100)
    }
}

struct DNABall: View {
    @State var delay: Double
    @State var ballSpeed: Double
    @State var ballSize: CGFloat
    @State var rect: CGSize
    @State var color: LinearGradient
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: self.ballSize, height: self.ballSize)
            .offset(x: 0, y: -(rect.height/2))
            .offset(x: 0, y: self.offsetY)
            .scaleEffect(self.scale)
            
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                    withAnimation(Animation.easeInOut(duration: self.ballSpeed).repeatForever(autoreverses: true)) {
                        self.offsetY = self.rect.height
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.ballSpeed/2) {
                        withAnimation(Animation.easeInOut(duration: self.ballSpeed).repeatForever(autoreverses: true)) {
                            self.scale = self.minBallScale
                        }
                    }
                }
            }
    }
    
    // MARK: - Drawing Constents
    let minBallScale: CGFloat = 0.65
}
struct DNABall_Previews: PreviewProvider {
    static var previews: some View {
        DNABall(delay: 0,
                ballSpeed: 1,
                ballSize: 30,
                rect: CGSize(width: 50, height: 100),
                color: LinearGradient(gradient: Gradient(colors: [firstC, secondC]), startPoint: .top, endPoint: .bottom)
        )
    }
}
