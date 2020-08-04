//
//  HeartButton.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 22/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct HeartButton: View {
    @State private var lifetime: Float = 0
    @State private var ringScale: CGFloat = 0
    @State private var ringOpacity: Double = 1
    @State private var imageScale: CGFloat = 1
    @State private var color = Color.gray
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(Color.gray, lineWidth: 8)
                .frame(width: 200, height: 200)
                .opacity(self.ringOpacity)
                .scaleEffect(self.ringScale)
            
            ParticlesEmitter {
                EmitterCell()
                    .content(.image((UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal))!))
                    .lifetime(self.lifetime)
                    .birthRate(100)
                    .velocity(100)
                    .scale(0.3)
                    .alphaSpeed(-0.2)
                    .scaleSpeed(-0.1)
                    .emissionRange(.pi * 2)
                    .yAcceleration(-30)
                    .color(UIColor.red)
            }
            .emitterSize(CGSize(width: 1, height: 1))
            .emitterShape(.circle)
            .frame(width: 1, height: 1)
            
            Rectangle()
                .frame(width: 100, height: 80)
                .foregroundColor(color)
                .mask(
                    Image(systemName: "heart.fill")
                        .resizable()
            )
                .scaleEffect(self.imageScale)
        }
        .onTapGesture {
            self.ringOpacity = 1
            self.ringScale = 0
            withAnimation(Animation.linear(duration: 0.3)) {
                self.imageScale = 0.6
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.ringScale = 1
                    self.imageScale = 1
                    self.ringOpacity = 0
                    self.lifetime = 1
                    self.color = .red
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation {
                    self.lifetime = 0
                }
            }
        }
    }
}

struct HeartButton_Previews: PreviewProvider {
    static var previews: some View {
        HeartButton()
    }
}
