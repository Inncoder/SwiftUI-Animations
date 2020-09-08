//
//  HalfpipeLoadingView.swift
//  Animations
//
//  Created by Inncoder on 13/08/2020.
//  Copyright © 2020 Inncoder AS. All rights reserved.
//

import SwiftUI

struct HalfpipeLoadingView: View {
    
    @State private var ballTrim1: CGFloat = 0
    @State private var ballTrim2: CGFloat = 0
    
    @State private var trailTrim1: CGFloat = 0
    @State private var trailTrim2: CGFloat = 0
    
    @State private var rightSide = true
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .foregroundColor(.gray)
                .frame(width: capsuleSize / 2, height: capsuleSize / 2)
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .frame(width: capsuleSize / 2, height: capsuleSize / 2)
                    .opacity(0)
                Capsule()
                    .trim(from: trailTrim1, to: trailTrim2)
                    .stroke(ballColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: capsuleSize, height: capsuleSize / 2)
                    .offset(x: 0, y: -capsuleSize / 4)
            }
            .mask(Circle().trim(from: 0, to: 0.5).stroke(Color.gray, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)))
            Capsule()
                .trim(from: ballTrim1, to: ballTrim2)
                .stroke(ballColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                .rotationEffect(.degrees(-90))
                .frame(width: capsuleSize, height: capsuleSize / 2)
                .offset(x: 0, y: -capsuleSize / 4)

        }
        .onAppear() {
            self.startAnimating()
        }
    }
    
    
    // MARK: - Drawing constants
    let capsuleSize: CGFloat = 300
    let lineWidth: CGFloat = 15
    let time: Double = 1.5
    let ballColor = AngularGradient(gradient: Gradient(colors: [.blue, .green]), center: .center)
    
    let trimRight: CGFloat = 0.20
    let trimLeft: CGFloat = 0.80
    
    
    // MARK: - Functions
    
    func setupRight() {
        self.ballTrim1 = trimRight
        self.ballTrim2 = trimRight + 0.001
        
        self.trailTrim1 = trimRight
        self.trailTrim2 = trimRight + 0.001
    }
    func setupLeft() {
        self.ballTrim1 = trimLeft
        self.ballTrim2 = trimLeft + 0.001
        
        self.trailTrim1 = trimLeft
        self.trailTrim2 = trimLeft + 0.001
    }
    
    func startAnimating() {
        Timer.scheduledTimer(withTimeInterval: self.time, repeats: true) { _ in
            if self.rightSide {
                self.setupRight()
                withAnimation(Animation.easeInOut(duration: self.time)) {
                    self.ballTrim1 = self.trimLeft
                    self.ballTrim2 = self.trimLeft + 0.001
                }
                withAnimation(Animation.easeInOut(duration: self.time)) {
                    self.trailTrim2 = self.trimLeft
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + self.time / 4) {
                    withAnimation(Animation.easeInOut(duration: self.time - (self.time * 0.40))) {
                       self.trailTrim1 = self.trimLeft
                   }
                }
            } else {
                self.setupLeft()
                withAnimation(Animation.easeInOut(duration: self.time)) {
                    self.ballTrim1 = self.trimRight
                    self.ballTrim2 = self.trimRight + 0.001
                }
                withAnimation(Animation.easeInOut(duration: self.time)) {
                    self.trailTrim1 = self.trimRight
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + self.time / 4) {
                    withAnimation(Animation.easeInOut(duration: self.time - (self.time * 0.40))) {
                       self.trailTrim2 = self.trimRight
                   }
                }
            }
            self.rightSide.toggle()
        }
    }
}

struct HalfpipeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        HalfpipeLoadingView()
    }
}
