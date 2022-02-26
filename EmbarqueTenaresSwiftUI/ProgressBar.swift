//
//  ProgressBar.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/22/22.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.75)
                    .foregroundColor(.lightAccent)
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width)
, height: geometry.size.height)
                    .foregroundColor(.accent)
            }.cornerRadius(45.0)
        }
    }
}
