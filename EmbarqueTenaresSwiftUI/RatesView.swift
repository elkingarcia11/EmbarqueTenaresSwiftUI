//
//  RatesView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//


import Foundation
import SwiftUI

struct RatesView: View {
    
    @StateObject var ratesViewModel = RatesViewModel()
    
    let whatsapp : LocalizedStringKey = "whatsapp"
    
    
    func openWhatsapp(){
        @Environment(\.openURL) var openURL
        
        if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
            openURL(url)
        }
    }
    
    // LOCALE CHANGE LOGIC
    var body: some View {
        VStack(alignment: .leading){
            
            List {
                if ratesViewModel.isLoading{
                    Spacer()
                    ProgressView()
                        .padding(.top)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(3)
                } else {
                    ForEach(ratesViewModel.catsAndItems) { catAndItem in
                        Collapsible(label: catAndItem.category.name_en){
                            ForEach(catAndItem.items) { item in
                                Divider()
                                HStack(alignment: .center){
                                    Text(item.name_en)
                                        .padding([.top, .trailing])
                                    Spacer()
                                    PricePill(price: item.price)
                                        .padding(.top)
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
            HStack(alignment: .center){
                Image("whatsapp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .leading, .bottom])
                    .frame(width: 75, height: 75)
                Text(whatsapp)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom, .trailing])
                    .frame(maxWidth: .infinity)
            }
            .frame(width: screenWidth)
            .overlay(
                RoundedRectangle(cornerRadius: 1)
                    .stroke(Color.accent, lineWidth: 1)
            )
            .onTapGesture{
                openWhatsapp()
            }
        }
    }
}

struct Collapsible<Content: View>: View {
    var label: String
    var content: () -> Content
    init(label: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.label = label
        self.content = content
    }
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                self.collapsed.toggle()
            }, label: {
                HStack {
                    Image(label)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                        .frame(width: 75, height: 75)
                    Text(label)
                        .fontWeight(.bold)
                    Spacer(minLength: 0)
                    Image(systemName: self.collapsed ? "chevron.right" : "chevron.down")
                        .frame(width: screenWidth/15)
                }
                .background(Color.white.opacity(0.1))
            }
            )
            .buttonStyle(PlainButtonStyle())
            self.content()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none, alignment: .top) // <- added `alignment` here
                .clipped() // Comment to see the overlap
        }
    }
}

struct PricePill: View {
    
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
