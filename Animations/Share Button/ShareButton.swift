//
//  ShareButton.swift
//  InstagramAnimation
//
//  Created by InnAppsCoding on 11/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct ShareButton: View {
    
    @State private var o1: CGFloat = 0
    @State private var o2: CGFloat = 300
    @State private var o3: CGFloat = 0
    
    @State private var shared = false
    @State private var text = "Share!"
    
    var body: some View {
        ZStack {
            ZStack {
//                ShareItems(shared: $shared,
//                           text: $text,
//                           o1: $o1,
//                           o2: $o2,
//                           o3: $o3)
                Sticker(shared: $shared,
                        text: $text,
                        o1: $o1,
                        o2: $o2,
                        o3: $o3)
            }
            .frame(width: 300, height: 100)
        }
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton()
    }
}
