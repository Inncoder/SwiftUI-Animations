//
//  TabBar.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 02/08/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

class TabItem: Identifiable, ObservableObject {
    let id = UUID().uuidString
    let imageName: String
    var offset: CGFloat = -10
    var opacity: Double = 1
    
    init(imageName: String, offset: CGFloat) {
        self.imageName = imageName
        self.offset = offset
    }
    init(imageName: String) {
        self.imageName = imageName
    }
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.id <= rhs.id
    }
}

class TabItems: ObservableObject {
    static let shared = TabItems()
    
    @Published var items: [TabItem] = [
        TabItem(imageName: "house.fill", offset: -40),
        TabItem(imageName: "magnifyingglass"),
        TabItem(imageName: "plus.app"),
        TabItem(imageName: "heart"),
        TabItem(imageName: "person.fill"),
    ]
    
    @Published var selectedTabIndex: CGFloat = 1
    
    func select(_ index: Int) {
        let tabItem = items[index]
        
        tabItem.opacity = 0
        tabItem.offset = 30
        
        withAnimation(Animation.easeInOut) {
            selectedTabIndex = CGFloat(index + 1)
            for i in 0..<items.count {
                if i != index {
                    items[i].offset = -10
                }
            }
        }
        withAnimation(Animation.easeOut(duration: 0.2).delay(0.2)) {
            tabItem.opacity = 1
            tabItem.offset = -40
        }
    }
}
