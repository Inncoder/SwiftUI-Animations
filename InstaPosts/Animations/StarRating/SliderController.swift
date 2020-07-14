//
//  SliderView.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 22/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct SliderController: View {
    
    @Binding var percentage: Float
    @Binding var lifetime: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color(.darkGray))
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            }
            .cornerRadius(12)
            .gesture(DragGesture(minimumDistance: 0)
            .onEnded({ _ in
                withAnimation() {
                    self.lifetime = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        self.lifetime = 0
                    }
                }
                
            })
            .onChanged({ value in
                self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
            }))
        }
    }
}

struct SliderController_Previews: PreviewProvider {
    static var previews: some View {
        SliderController(percentage: .constant(50), lifetime: .constant(0))
    }
}
