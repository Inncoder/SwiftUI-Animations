//
//  LikeButton.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 21/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct LikeButton: View {
    
    @State private var ringScale: CGFloat = 0
    @State private var ringOpacity: Double = 1
    @State private var imageScale: CGFloat = 1
    @State private var imageRotation: Double = 0
    @State private var orbOffset: Double = 0
    @State private var ordScale: CGFloat = 0
    @State private var color = Color.gray
    
    var body: some View {
        ZStack {
            
            ForEach(0..<8) {
                Circle()
                    .foregroundColor(Color(UIColor(red: 0.00, green: 0.00, blue: 1.0, alpha: 1.00)))
                    .frame(width: ($0.isMultiple(of: 2) ? 15 : 5), height: ($0.isMultiple(of: 2) ? 15 : 5))
                    .scaleEffect(self.ordScale)
                    .opacity($0.isMultiple(of: 2) ? 1 : 0.5)
                    .offset(CGSize(width: 0, height: ($0.isMultiple(of: 2) ? self.orbOffset : self.orbOffset/1.2)))
                    .rotationEffect(.degrees(Double(($0 * 45))))
            }
            
            Circle()
                .stroke(Color.gray, lineWidth: 8)
                .frame(width: 100, height: 100)
                .opacity(self.ringOpacity)
                .scaleEffect(self.ringScale)

            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundColor(color)
                .mask(
                    Image("like")
                        .resizable()
                )
                .scaleEffect(self.imageScale)
                .rotationEffect(.degrees(self.imageRotation))
        }
        .onTapGesture {
            self.orbOffset = 0
            self.ringOpacity = 1
            self.ringScale = 0
            withAnimation(Animation.linear(duration: 0.3)) {
                self.imageScale = 0.6
                self.imageRotation = -30
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(Animation.linear(duration: 0.6)) {
                    self.orbOffset = -50
                }
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.color = Color.blue
                    self.ordScale  = 1
                    self.ringScale = 1
                    self.imageScale = 1
                    self.ringOpacity = 0
                    self.imageRotation = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.ordScale = 0
                }
            }
        }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton()
    }
}
