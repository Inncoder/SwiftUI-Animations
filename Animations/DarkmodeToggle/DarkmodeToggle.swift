//
//  DarkmodeToggle.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 20/07/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct DarkmodeToggle: View {
    let darkBackground = UIColor(
        red: 0.189, green: 0.187, blue: 0.256, alpha: 1.0
        )
    @State private var darkmode = false
    var body: some View {
        ZStack {
            Color(darkmode ? darkBackground : .white)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Color(self.darkmode ?
                    UIColor.black :
                    UIColor(red: 0.67,
                            green: 0.81,
                            blue: 1.00,
                            alpha: 1.00)
                    )
                MiniImages(darkmode: $darkmode)
            }
            .frame(width: 100, height: 50)
            .mask(
                Capsule()
                    .foregroundColor(self.darkmode ?
                        Color.black :
                        Color(UIColor(red: 0.67,
                                      green: 0.81,
                                      blue: 1.00,
                                      alpha: 1.00))
                        )
            )
            ZStack {
                Circle()
                    .foregroundColor(darkmode ?
                        .white :
                        .yellow
                    )
                    .frame(width: 45, height: 45)
                Circle()
                    .foregroundColor(self.darkmode ?
                        Color.black :
                        Color(UIColor(red: 0.67,
                                      green: 0.81,
                                      blue: 1.00,
                                      alpha: 1.00))
                        )
                    .offset(x: darkmode ? -22.5: -45)
                    .rotationEffect(.degrees(darkmode ?
                        45:
                        0)
                    )
                    .frame(width: 45, height: 45)
            }
            .offset(x: darkmode ?
                23 :
                -23
            )
            .mask(
                Circle()
                    .frame(width: 45, height: 45)
                    .offset(x: darkmode ? 23 : -23)
            )
            
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                withAnimation(Animation.easeIn) {
                    self.darkmode.toggle()
                }
            }
        }
    }
}

struct DarkmodeToggle_Previews: PreviewProvider {
    static var previews: some View {
        DarkmodeToggle()
    }
}

struct MiniImages: View {
    
    @Binding var darkmode: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 15, y: 0)
                .opacity(darkmode ? 0 : 1)
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 30, y: 10)
                .opacity(darkmode ? 0 : 1)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -20, y: -12)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -5, y: -5)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -25, y: 10)
                .opacity(darkmode ? 1 : 0)
        }
    }
}
