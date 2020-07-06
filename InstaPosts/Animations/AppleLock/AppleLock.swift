//
//  AppleLock.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 24/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct AppleLock: View {
    @State private var leafSize: CGFloat = 50
    @State private var rotation: Double = 90
    @State private var lockOffset: (CGFloat, CGFloat) = (80, 0)
    @State private var appleLogoOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .cornerRadius(50)
                .frame(width: 350, height: 350)
                .offset(x: 0, y: -30)
                .shadow(color: .gray, radius: 12, x: 13, y: 13)
            
            Capsule()
                .trim(from: 0.4, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .frame(width: 80, height: 125)
                .foregroundColor(.white)
                .rotation3DEffect(.degrees(self.rotation), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint(x: 0, y: 0), anchorZ: 1, perspective: 1)
                .offset(x: lockOffset.0, y: lockOffset.1)
            
            AppleLogo(leafSize: $leafSize)
                .frame(width: 442/2, height: 377/2)
                .offset(x: 0, y: self.appleLogoOffset)
            
        }
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.3)) {
                self.leafSize = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.rotation = 0
                    self.lockOffset = (80, -110)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                withAnimation(Animation.linear(duration: 0.5)) {
                    self.rotation = 180
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.lockOffset = (80, -80)
                }
                withAnimation(Animation.linear(duration: 0.15).delay(0.15)) {
                    self.appleLogoOffset = 10
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(Animation.linear(duration: 0.15)) {
                    self.lockOffset = (80, -90)
                    self.appleLogoOffset = 0
                }
            }
        }
    }
}

struct AppleLock_Previews: PreviewProvider {
    static var previews: some View {
        AppleLock()
    }
}

struct Leaf: Shape {
     func path(in rect: CGRect) -> Path {
       var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.midX/4, y: rect.midY/4))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control: CGPoint(x: rect.maxX/1.2, y: rect.maxY/1.2))
        return path
    }
}


struct AppleLogo: View {
    @Binding var leafSize: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Leaf()
                .frame(width: leafSize, height: leafSize, alignment: .bottomLeading)
                .foregroundColor(.white)
                .offset(x: 105, y: -180)
            
            ZStack(alignment: .bottomLeading) {
                Image("apple")
                    .resizable()
                    .frame(width: 422/2, height: 377/2)
            }
        }
    }
}
