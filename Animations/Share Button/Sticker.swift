//
//  Sticker.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 11/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct Sticker: View {
    
    @Binding var shared: Bool
    @Binding var text: String
    @Binding var o1: CGFloat
    @Binding var o2: CGFloat
    @Binding var o3: CGFloat
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(UIColor(red: 0.00, green: 0.62, blue: 1.00, alpha: 1.00)),
            Color(UIColor(red: 0.35, green: 0.75, blue: 1.00, alpha: 1.00))
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        ZStack {
            if !shared {
                ZStack {
                    Capsule()
                        .fill(gradient)
                        .frame(width: 300, height: 100)
                        .offset(x: 0, y: 0)
                        .mask(Capsule())
                    Text(text)
                        .font(.largeTitle)
                }
                .mask(Rectangle().offset(x: o1, y: 0))
                    
                .onTapGesture {
                    withAnimation(Animation.linear(duration: 1)) {
                        withAnimation(Animation.linear(duration: 1.5)) {
                            self.o1 = -290
                            self.o2 = 10
                            self.o3 = -290
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.shared = true
                    }
                }
            }
            ZStack {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 100)
                    .offset(x: o2, y: 0)
            }
            .mask(Rectangle())
            .offset(x: o3, y: 0)
        }
    }
}

