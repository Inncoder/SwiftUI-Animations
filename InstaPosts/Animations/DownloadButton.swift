//
//  DownloadButton.swift
//  InstagramAnimation
//
//  Created by InnAppsCoding on 10/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct DownloadButton: View {
    
    @State private var left: CGPoint = CGPoint(x: 20, y: 70)
    @State private var right: CGPoint = CGPoint(x: 80, y: 70)
    @State private var height: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var offset: (CGFloat, CGFloat) = (0, 0)
    @State private var color = Color.green
    @State private var downloading = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 150)
                Circle()
                    .stroke(Color.green, lineWidth: 5)
                    .frame(width: 150, height: 150)
                FillCircle(endAngle: rotation)
                    .frame(width: 140, height: 140)
                    .foregroundColor(.green)
                Arrow(left: left, right: right, height: height)
                    .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .offset(x: 0, y: offset.1)
                    .rotationEffect(.degrees(rotation))
            }
            .onTapGesture {
                if !self.downloading {
                    self.downloading = true
                    withAnimation(Animation.linear(duration: 0.3)) {
                        self.left = CGPoint(x: 50, y: 100)
                        self.right = CGPoint(x: 50, y: 100)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(Animation.easeInOut(duration: 0.3)) {
                            self.height = 28
                            self.offset.1 = -50
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            self.rotation = 360
                            self.height = 100
                            self.color = Color.white
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(Animation.easeInOut(duration: 0.3)) {
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                        withAnimation(Animation.linear(duration: 0.2)) {
                            self.offset.1 += 17.5
                        }
                        withAnimation(Animation.easeInOut(duration: 0.3).delay(0.2)) {
                            self.offset.0 = 2.5
                            self.left = CGPoint(x: 35, y: 85)
                            self.right = CGPoint(x: 70, y: 80)
                        }
                        self.downloading = false
                    }
                }
            }
            Button(action: {
                if !self.downloading {
                    self.left = CGPoint(x: 20, y: 70)
                    self.right = CGPoint(x: 80, y: 70)
                    self.height = 0
                    self.rotation = 0
                    self.offset = (0, 0)
                    self.color = Color.green
                    self.downloading = false
                }
            }) {
                Text("reset")
            }
        }
    }
}




struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton()
    }
}

struct Arrow: Shape {
    var left: CGPoint
    var right: CGPoint
    var height: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData>> {
        get { (AnimatablePair(height, AnimatablePair(left.animatableData, right.animatableData))) }
        set {
            height = newValue.first
            right.animatableData = newValue.second.first
            left.animatableData = newValue.second.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: height))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.move(to: left)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addLine(to: right)
        
        return path
    }
}

struct FillCircle: Shape {
    var endAngle: Double
    
    var animatableData: Double {
        get { endAngle }
        set { endAngle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height/2, startAngle: .degrees(endAngle - 90), endAngle: .degrees(-90), clockwise: true)
        
        return path
    }
}

