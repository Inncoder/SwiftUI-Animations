//
//  ShareItems.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 11/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct ShareItems: View {
    
    @Binding var shared: Bool
    @Binding var text: String
    @Binding var o1: CGFloat
    @Binding var o2: CGFloat
    @Binding var o3: CGFloat
    
    @State private var b1Tapped = false
    
    var body: some View {
        ZStack {
            
            Capsule()
                .stroke(Color.gray, lineWidth: 4)
                .blur(radius: 5)
                .frame(width: 300, height: 100)
                .offset(x: 2, y: 3)
                .clipShape(Capsule())
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.share()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 5, x: 2, y: 3)
                        Image("twitter")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    self.share()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: .gray, radius: 5, x: 2, y: 3)
                        Image("facebook")
                            .resizable()
                            .frame(width: 55, height: 40)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    self.share()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: .gray, radius: 5, x: 2, y: 3)
                        Image("instagram")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
        }
    }
    func share() {
        self.shared = false
        self.text = "Thank You!"
        withAnimation(Animation.linear(duration: 1)) {
            self.o1 = 0
            self.o2 = 300
            self.o3 = 0
        }
    }
}

