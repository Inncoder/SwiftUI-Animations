////
////  Slider.swift
////  InstaPosts
////
////  Created by InnAppsCoding on 19/06/2020.
////  Copyright © 2020 InnAppsCoding. All rights reserved.
////
//
//import SwiftUI
//import PureSwiftUI
//
//struct Slider: View {
//    @State var percentage: Float = 50
//    @State var width: CGFloat
//    var body: some View {
//        ZStack(alignment: .center) {
//            Capsule()
//                .foregroundColor(.blue)
//                .frame(width: width < 100 ? 100 : width, height: 50)
//            SliderBase(percentage: $percentage)
//                .frame(width: width < 100 ? 100-65 : width-65, height: 50)
//        }
//    }
//}
//
//struct SliderBase: View {
//    @Binding var percentage: Float
//    @State private var animated = false
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .foregroundColor(.blue)
//                SliderTop(animate: self.$animated, percentage: self.$percentage)
//                    .offset((geometry.size.width * CGFloat(self.percentage / 100)-25), self.animated ? -55 : 0)
//            }
//            .gesture(DragGesture(minimumDistance: 0)
//            .onEnded({ _ in
//                withAnimation() {
//                    self.animated = false
//                }
//            })
//            .onChanged({ value in
//                withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.9)) {
//                    self.animated = true
//                }
//                self.percentage = min(max(0, Float(value.location.x / (geometry.size.width) * 100)), 100)
//            }))
//            
//        }
//    }
//}
//
//struct SliderTop: View {
//    @Binding var animate: Bool
//    @Binding var percentage: Float
//
//    var body: some View {
//        ZStack {
//            Trapezoid(animate: animate)
//                .foregroundColor(.blue)
//                .frame(width: 35, height: 15)
//                .offset(0, 25)
//            Circle()
//                .foregroundColor(.blue)
//                .frame(50)
//            Circle()
//                .foregroundColor(.white)
//                .frame(40)
//            Text("\(Int(percentage))")
//                .foregroundColor(.black)
//        }
//    }
//}
//
//struct Trapezoid: Shape {
//    private let layoutGrid = LayoutGuideConfig.grid(columns: 4, rows: 4)
//    private var factor: Double
//
//    init(animate: Bool = true) {
//        self.factor = animate ? 0 : 1
//    }
//
//    var animatableData: Double {
//        get {
//            factor
//        }
//        set {
//            factor = newValue
//        }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        var g = layoutGrid.layout(in: rect)
//        var path = Path()
//        path.move(g[0, 4].to(g[2, 0], factor))
//        path.addQuadCurve(to: g[0, 0].to(g[2, 0], factor), control: g[1, 2].to(g[2, 0], factor))
//        path.addLine(to: g[4, 0].to(g[2, 0], factor))
//        path.addQuadCurve(to: g[4, 4].to(g[2, 0], factor), control: g[3, 2].to(g[2, 0], factor))
//        return path
//    }
//}
