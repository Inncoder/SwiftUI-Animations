//
//  StarRating.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 22/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct StarRating: View {
    
    @State private var percentage: Float = 50
    @State private var lifetime: Float = 0
    var body: some View {
        ZStack {
            ParticlesEmitter {
                EmitterCell()
                    .content(.image(UIImage(systemName: "star")!))
                    .lifetime(self.lifetime)
                    .birthRate(100)
                    .velocity(100)
                    .scale(0.3)
                    .alphaSpeed(-0.2)
                    .scaleSpeed(-0.1)
                    .emissionRange(.pi * 2)
                    .yAcceleration(-30)
                    .color(UIColor.yellow)
            }
            .emitterSize(CGSize(width: 1, height: 1))
            .emitterShape(.circle)
            .frame(width: 1, height: 1)
            .offset(x: (2.4 * CGFloat(self.percentage))-120, y: 0)
            
            SliderController(percentage: $percentage, lifetime: $lifetime)
                .mask(Stars())
                .frame(width: 240, height: 40)
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating()
    }
}
