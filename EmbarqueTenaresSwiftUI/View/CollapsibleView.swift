//
//  CollapsibleView.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/13/22.
//

import Foundation
import SwiftUI
struct CollapsibleView<Content: View>: View {
    var image: String
    var label: String
    
    var content: () -> Content
    
    init(image: String, label: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.image = image
        self.label = label
        self.content = content
    }
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.vertical)
                            .frame(width: 75, height: 75)
                        
                        Text(label)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: self.collapsed ? "chevron.right" : "chevron.down")
                            .padding(.trailing)
                            .frame(width: screenWidth/15)
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            self.content()
                .background(Color.light)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none, alignment: .top) // <- added `alignment` here
                .clipped() // Comment to see the overlap
        }
        .frame(width: screenWidth)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
