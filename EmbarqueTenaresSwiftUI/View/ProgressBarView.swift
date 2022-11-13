//
//  ProgressBarView.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/13/22.
//

import Foundation
import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Float
    @State var daysLeft: Int
    let daysL : LocalizedStringKey = "daysLeft"
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.primary)
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.primary)
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            VStack{
                Text("\(daysLeft)")
                    .font(.title)
                    .bold()
                Text(daysL)
                    .font(.title2)
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity)
    }
}

