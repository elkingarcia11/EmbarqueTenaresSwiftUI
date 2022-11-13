//
//  PricePillView.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/13/22.
//

import Foundation
import SwiftUI

struct PricePillView: View {
    
    var price: String
    var fontSize: CGFloat = 20.0
    
    var body: some View {
        ZStack {
            Text(price)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.accent)
                .cornerRadius(5)
        }
    }
}

