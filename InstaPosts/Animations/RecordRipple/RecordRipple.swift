//
//  Wave.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 24/07/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct RecordRipple: View {

    @State private var waveSize: CGFloat = 100
    @State private var opacity = 1.0
    @State private var logoSize: CGFloat = 50
    
    @State private var shadowOpacity1 = 0.2
    @State private var shadowOpacity2 = 0.7
    @State private var shadowOpacity12 = 0.0
    @State private var shadowOpacity22 = 0.0
    
    @State private var recording = false
    @State private var animating = false
    
    let darkGradient = Gradient(colors: [Color(UIColor(red: 0.192, green: 0.212, blue: 0.329, alpha: 1.000)), Color(UIColor(red: 0.565, green: 0.608, blue: 0.667, alpha: 1.000))])
    let redGradient = Gradient(colors: [Color(UIColor(red: 0.51, green: 0.22, blue: 0.22, alpha: 1.00)), Color(UIColor(red: 0.81, green: 0.22, blue: 0.22, alpha: 1.00))])
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            // The wave
            Circle()
                .stroke(lineWidth: 10)
                .fill(Color.offWhite)
                .frame(width: self.waveSize, height: self.waveSize)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                .blur(radius: 5)
                .opacity(self.opacity)
            
            ZStack {
                // Circle unpressed
                Circle()
                    .fill(Color.offWhite)
                    .frame(width: 150, height: 150)
                    .shadow(color: Color.black.opacity(self.shadowOpacity1), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(self.shadowOpacity2), radius: 10, x: -5, y: -5)
                
                ZStack{
                    // Circle pressed
                    Circle()
                        .stroke(Color.offWhite, lineWidth: 1)
                        .shadow(color: Color.black.opacity(self.shadowOpacity12), radius: 3, x: 5, y: 5)
                        .clipShape(
                            Circle()
                        )
                        .shadow(color: Color.white.opacity(self.shadowOpacity22), radius: 2, x: -2, y: -2)
                        .clipShape(
                            Circle()
                        )
                        .frame(width: 150, height: 150)
                }
                .mask(Circle().frame(width: 150, height: 150))
                
                // Mic logo
                LinearGradient(
                    gradient: self.recording ? redGradient : darkGradient,
                  startPoint: .leading,
                  endPoint: .trailing
                )
                    .frame(width: self.logoSize, height: self.logoSize)
                    .mask(Image(systemName: "mic.fill")
                        .resizable()
                        .scaledToFit()
                )
            }
            .onTapGesture {
                
                withAnimation(Animation.easeIn(duration: 0.15)) {
                    self.shadowOpacity1 = 0.0
                    self.shadowOpacity2 = 0.0
                    self.logoSize = 45
                }
                withAnimation(Animation.easeOut(duration: 0.15)) {
                    self.shadowOpacity12 = 0.2
                    self.shadowOpacity22 = 0.7
                    self.logoSize = 40
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(Animation.easeIn(duration: 0.15)) {
                        self.shadowOpacity12 = 0.0
                        self.shadowOpacity22 = 0.0
                        self.logoSize = 45
                    }
                    withAnimation(Animation.easeOut(duration: 0.15)) {
                        self.shadowOpacity1 = 0.2
                        self.shadowOpacity2 = 0.7
                        self.logoSize = 50
                    }
                }
                
                self.recording.toggle()
                if self.recording && !self.animating {
                    self.waveSize = 100
                    self.opacity = 1
                    withAnimation(Animation.linear(duration: 2)) {
                        self.waveSize = 500
                        self.opacity = 0
                    }
                    self.animating = true
                    self.startWave()
                }
            }
        }
    }
    func startWave()  {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if self.recording {
                self.waveSize = 100
                self.opacity = 1
                withAnimation(Animation.linear(duration: 2)) {
                    self.waveSize = 500
                    self.opacity = 0
                }
            } else {
                timer.invalidate()
                self.animating = false
            }
        }
    }
}

struct RecordRipple_Previews: PreviewProvider {
    static var previews: some View {
        RecordRipple()
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}
