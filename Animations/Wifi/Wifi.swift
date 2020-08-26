//
//  Wifi.swift
//  InstagramAnimation
//
//  Created by Inncoder on 20/08/2020.
//  Copyright © 2020 Inncoder. All rights reserved.
//

import SwiftUI

struct Wifi: View {
    
    @State private var strokeFrom: CGFloat  = 0.62   //Need to be the same as strokeLeft
    @State private var strokeTo: CGFloat  = 0.62     //Need to be the same as strokeLeft
    @State private var wiperHeight: CGFloat = 0
    @State private var leftSide = true
    
    var body: some View {
        ZStack {
            Color.offWhite.edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.offWhite)
                .frame(width: 150, height: 150)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .trim(from: self.strokeLeft, to: self.strokeRight)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: self.size/2, lineCap: .round))
                        .foregroundColor(.gray)
                        .frame(width: self.size * 3 + self.size * CGFloat(i) * 2,
                               height: self.size * 3 + self.size * CGFloat(i) * 2)
                }
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .trim(from: self.strokeFrom, to: self.strokeTo)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: self.size/2, lineCap: .round))
                        .frame(width: self.size * 3 + self.size * CGFloat(i) * 2,
                               height: self.size * 3 + self.size * CGFloat(i) * 2)
                }
                Capsule()
                    .frame(width: size/2, height: wiperHeight)
                    .offset(x: 0, y: -(wiperHeight/2))
                    .rotationEffect(.degrees(self.leftSide ? -48 : 48))
            }
            .offset(x: 0, y: 30)
        }
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.wiperHeight = self.size * 4
                self.startSwipe()
            }
        }
    }
    
    // MARK: - Drawing constants
    let size: CGFloat = 17
    let strokeLeft: CGFloat = 0.62
    let strokeRight: CGFloat = 0.88
    
    
    // MARK: - Functions
    func startSwipe() {
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { timer in
            count += 1
            if self.leftSide {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.leftSide = false
                    self.strokeTo = self.strokeRight
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(Animation.easeInOut(duration: 0.25)) {
                        self.strokeFrom = self.strokeRight
                    }
                }
            } else {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.leftSide = true
                    self.strokeFrom = self.strokeLeft
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(Animation.easeInOut(duration: 0.25)) {
                        self.strokeTo = self.strokeLeft
                    }
                }
            }
            if count == 3 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        self.leftSide = true
                        self.strokeFrom = self.strokeLeft
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            self.wiperHeight = 0
                        }
                    }
                }
            }
        }
    }
}

struct Wifi_Previews: PreviewProvider {
    static var previews: some View {
        Wifi()
    }
}
