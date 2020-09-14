//
//  Search.swift
//  Animations
//
//  Created by Inncoder on 14/09/2020.
//  Copyright © 2020 Inncoder AS. All rights reserved.
//

import SwiftUI

struct Search: View {
    
    @State private var searching = false
    @State private var searchText = ""
    
    @State private var trimTo: CGFloat = 0
    @State private var lineOffset: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var xRotation: Double = 0
    @State private var opacity: Double = 0
    
    
    var body: some View {
        HStack {
           ZStack {
                TextField("", text: $searchText, onEditingChanged: { _ in
                    self.animateToX()
                })
                    .frame(width: textFieldSize, height: size)
                Capsule()
                    .stroke(lineWidth: strokeWidth)
                    .frame(width: textFieldSize + 20, height: size + 10)
            }
           .padding()
            ZStack {
                Circle()
                    .stroke(lineWidth: strokeWidth)
                    .frame(width: size, height: size)
                Circle()
                    .trim(from: 0, to: trimTo)
                    .stroke(lineWidth: size / 2)
                    .frame(width: size / 2, height: size / 2)
                    .rotationEffect(.degrees(45))
                
                Capsule()
                    .frame(width: size / 2, height: strokeWidth)
                    .offset(x: size / 4, y: 0)
                    .offset(x: lineOffset, y: 0)
                    .rotationEffect(.degrees(rotation))
                
                ZStack {
                    Capsule()
                        .rotationEffect(.degrees(-xRotation))
                    Capsule()
                        .rotationEffect(.degrees(xRotation))
                }
                .frame(width: size / 2, height: strokeWidth / 2)
                .foregroundColor(.white)
                .opacity(opacity)
            }
            .onTapGesture {
                self.searchText = ""
                self.animateToSearch()
            }
        }
        .onAppear {
            self.lineOffset = self.size / 2
            self.rotation = 45
        }
    }
    
    // MARK: - Drawing constants
    let size: CGFloat = 30
    let textFieldSize: CGFloat = 150
    let strokeWidth: CGFloat = 5
    let animationDuration: Double = 0.6
    
    // MARK: - Functions
    func animateToX() {
        if !self.searching {
            withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                self.lineOffset = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration / 3 * 2) {
                withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                    self.rotation = 360
                    self.trimTo = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.animationDuration / 3) * 3) {
                withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                    self.opacity = 1
                    self.xRotation = 45
                }
            }
            self.searching = true
        }
    }
    
    func animateToSearch() {
        if self.searching {
            withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                self.opacity = 0
                self.xRotation = 0
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration / 3) {
                withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                    self.rotation = 45
                    self.trimTo = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.animationDuration / 3) * 2) {
                withAnimation(Animation.linear(duration: self.animationDuration / 3)) {
                    self.lineOffset = self.size / 2
                }
            }
        }
        self.searching = false
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
