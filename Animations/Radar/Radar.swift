//
//  Radar.swift
//  Animations
//
//  Created by Inncoder on 25/08/2020.
//  Copyright © 2020 Inncoder. All rights reserved.
//

import SwiftUI

struct Marker: Identifiable, Hashable {
    var id: Int
    var offet: CGFloat
    var degrees: Double
}

struct Radar: View {
    @State private var rotation: Double = 0
    @State private var opasity: Double = 1
    
    private var markers: [Marker] = []
    private var scannerTailColor: AngularGradient = AngularGradient(
        gradient: Gradient(colors: [Color.blue]),
        center: .center
    )
    
    init() {
        self.markers = randomMarkersList()
        self.scannerTailColor = AngularGradient(
            gradient: Gradient(colors: [color.opacity(0), color.opacity(1)]),
            center: .center
        )
    }
    
    var body: some View {
        ZStack {
            Color.offWhite.edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.offWhite)
                .frame(width: self.scannerSize, height: self.scannerSize)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            // Markers
            ForEach(markers, id: \.self) { m in
                Circle()
                    .opacity(self.opasity)
                    .animation(
                        Animation
                            .linear(duration: self.scannerSpeed)
                            .repeatForever(autoreverses: false)
                            .delay((self.scannerSpeed / 360) * (90 + m.degrees))
                    )
                    .frame(width: self.markerSize, height: self.markerSize)
                    .foregroundColor(self.color)
                    .offset(x: m.offet, y: 0)
                    .rotationEffect(.degrees(m.degrees))
                .blur(radius: 2)
            }
            // Scanner tail
            Circle()
                .trim(from: 0, to: 0.375)
                .stroke(lineWidth: self.scannerSize / 2)
                .fill(scannerTailColor)
                .frame(width: self.scannerSize / 2, height: self.scannerSize / 2)
                .rotationEffect(.degrees(135 + self.rotation))
            
            // Scanner line
            Rectangle()
                .frame(width: 4, height: (self.scannerSize / 2))
                .offset(x: 0, y: -self.scannerSize / 4)
                .rotationEffect(.degrees(self.rotation))
                .foregroundColor(self.color)
            
            // Scanner middle point
            Circle()
                .frame(width: self.middlePointSize, height: self.middlePointSize)
                .foregroundColor(self.color)
        }
        .onAppear {
            self.opasity = 0
            withAnimation(Animation.linear(duration: self.scannerSpeed).repeatForever(autoreverses: false)) {
                self.rotation = 360
            }
        }
    }
    
    func randomMarkersList() -> [Marker] {
        var markers = [Marker]()
        
        for i in 0..<self.markerCount {
            let randomXOffset = CGFloat(Int.random(in: Int(markerSize)...Int((self.scannerSize / 2) - markerSize)))
            let randomDegree = Double(Int.random(in: 0...360))
            
            markers.append(Marker(id: i, offet: randomXOffset, degrees: randomDegree))
        }
        return markers
    }
    
    
    // MARK: - Drawing constants
    
    let degrees: Double = 90
    let middlePointSize: CGFloat = 15
    let scannerSize: CGFloat = 250
    let markerSize: CGFloat = 10
    let markerCount: Int = 7
    let scannerSpeed: Double = 1.5
    let color: Color = .green
}

struct Radar_Previews: PreviewProvider {
    static var previews: some View {
        Radar()
    }
}
