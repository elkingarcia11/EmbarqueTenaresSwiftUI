//
//  RatesView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//


import Foundation
import SwiftUI

struct ListData: Identifiable,Hashable {
    var id = UUID()
    var category: String
    var description: String
    var price: String
}

/**
 icons - box, barrels, tv, furniture, appliances
 */

var data = [
    ListData(category: "Boxes", description: "18X18X28 CON COMIDA", price: "$85"),
    ListData(category: "Boxes", description: "18x18x28 con ropa usada", price: "$85"),
    ListData(category: "Boxes", description: "18x18x28 con comida y ropa usada", price: "$85"),
    ListData(category: "Boxes", description: "18x18x28 de comida y/o ropa usada", price: "$110"),
    ListData(category: "Barrels", description: "de 55 galones con comida y/o ropa usada", price: "$125"),
    ListData(category: "Barrels", description: "de 77 galones con comida y/o ropa usada", price: "$150"),
    ListData(category: "TV", description: "de 32 pulgada", price: "$192"),
    ListData(category: "TV", description: "de 36 pulgada", price: "$216"),
    ListData(category: "TV", description: "de 42 pulgada", price: "$252"),
    ListData(category: "TV", description: "de 43 pulgada", price: "$387"),
    ListData(category: "TV", description: "de 50 pulgada", price: "$470"),
    ListData(category: "TV", description: "de 55 pulgada", price: "$495"),
    ListData(category: "TV", description: "de 65 pulgada", price: "$585"),
    ListData(category: "TV", description: "de 75 pulgada", price: "$675"),
    ListData(category: "Furniture", description: "Mattress twin", price: "85"),
    ListData(category: "Furniture", description: "Mattress y base twin", price: "85"),
    ListData(category: "Furniture", description: "Mattress queen", price: "85"),
    ListData(category: "Furniture", description: "Mattress y base queen", price: "85"),
    ListData(category: "Furniture", description: "Mattress king", price: "85"),
    ListData(category: "Furniture", description: "Mattress y base king", price: "85"),
    ListData(category: "Furniture", description: "Mueble de 1 asiento", price: "150+"),
    ListData(category: "Furniture", description: "Mueble de 2 asientos", price: "300+"),
    ListData(category: "Furniture", description: "Mueble de 3 asientos", price: "450+"),
    ListData(category: "Furniture", description: "Silla de rueda cerrada", price: "60"),
    ListData(category: "Furniture", description: "Silla de rueda electrica", price: "150"),
    ListData(category: "Appliances", description: "Lavadora", price: "250+"),
    ListData(category: "Appliances", description: "Secadora", price: "250+"),
    ListData(category: "Appliances", description: "Nevera con puerta arriba y abajo", price: "350+"),
    ListData(category: "Appliances", description: "Nevera con 2 puerta arriba y 1 abajo", price: "500+"),
    ListData(category: "Appliances", description: "Estufa", price: "250+"),
]

struct RatesView: View {
    
    let whatsapp : LocalizedStringKey = "whatsapp"
    
    var categories : [String] = ["Boxes","Barrels","TV","Furniture", "Appliances"]
    
    @State var d = data
    
    func openWhatsapp(){
        @Environment(\.openURL) var openURL
        
        if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
            openURL(url)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            List {
                ForEach(0..<categories.count-1) { index in
                    Collapsible(label: categories[index]){
                        ForEach(data) { listData in
                            if listData.category == categories[index] {
                                Divider()
                                HStack(alignment: .center){
                                    Text(listData.description)
                                        .padding([.top, .trailing])
                                    Spacer()
                                    PricePill(price: listData.price)
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
                    Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
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
