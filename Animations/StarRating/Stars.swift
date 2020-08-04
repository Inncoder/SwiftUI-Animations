//
//  Stars.swift
//  InstaPosts
//
//  Created by InnAppsCoding on 22/06/2020.
//  Copyright © 2020 InnAppsCoding. All rights reserved.
//

import SwiftUI

struct Stars: View {
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1..<6) { _ in
                Image(systemName: "star.fill")
                .resizable()
            }
        }
    }
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars()
    }
}
