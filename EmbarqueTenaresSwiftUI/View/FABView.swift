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
                HStack(alignment: .center){
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    Text(text)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .frame(width: 100)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            .background(Color.whatsappGreen)
            .foregroundColor(.black)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.whatsappGreen, lineWidth: 2)
            )
            .padding()
        } //body
    }
}
