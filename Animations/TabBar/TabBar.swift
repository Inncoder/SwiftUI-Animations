//
//  TabBar.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 02/08/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    let darkBackground = UIColor(red: 0.189, green: 0.187, blue: 0.256, alpha: 1.0)

    @ObservedObject var tabItems = TabItems.shared
    
    @State private var circleSize: CGFloat = 50
    @State private var iconeSize: CGFloat = 30
    
    var body: some View {
        ZStack {
            Color(darkBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack {
                    Bar(tab: tabItems.selectedTabIndex)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                    HStack(spacing: (UIScreen.main.bounds.width - (CGFloat(TabItems.shared.items.count + 1) * self.circleSize)) / (CGFloat(TabItems.shared.items.count) + 1)) {
                        ForEach(0..<tabItems.items.count, id: \.self) { i in
                            ZStack {
                                Circle()
                                    .frame(width: self.circleSize, height: self.circleSize)
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        self.tabItems.select(i)
                                        
                                        // Code to change tab screen can go here...
                                        
                                    }
                                Image(systemName: self.tabItems.items[i].imageName)
                                    .resizable()
                                    .foregroundColor(Color(self.darkBackground))
                                    .frame(width: self.iconeSize, height: self.iconeSize)
                                    .opacity(self.tabItems.items[i].opacity)
                            }
                            .offset(y: self.tabItems.items[i].offset)
                            
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
