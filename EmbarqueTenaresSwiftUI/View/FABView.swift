//
//  FABView.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 11/13/22.
//

import Foundation
import SwiftUI

struct FABView : View {
    @State var text  : LocalizedStringKey
    @State var image : String
    
    func openWhatsapp(){
        @Environment(\.openURL) var openURL
        
        if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
            openURL(url)
        }
    }
    
    var body: some View {
        HStack{
            Spacer()
                    Button(action: {
                        openWhatsapp()
                    }) {
                        VStack(alignment: .center, spacing:0){
                            Text(text)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .font(.caption)
                                .padding(.bottom)
                                .frame(width: 100)
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 25)
                    }
                    .background(Color.lightAccent)
                    .foregroundColor(.black)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.lightDark, lineWidth: 2)
                    )
                    .padding()
        } //body
        
    }
}
