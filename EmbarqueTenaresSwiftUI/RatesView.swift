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
    var title: String
    var description: String
    var price: String
    var icon: String
}

/**
 icons - box, barrels, tv, furniture, appliances
 */

var data = [
    ListData(title: "CAJA", description: "18X18X28 CON COMIDA", price: "$85", icon: "box"),
    ListData(title: "Caja", description: "18x18x28 con ropa usada", price: "$85", icon: "box"),
    ListData(title: "Caja", description: "18x18x28 con comida y ropa usada", price: "$85", icon: "box"),
    ListData(title: "Caja", description: "18x18x28 de comida y/o ropa usada", price: "$110", icon: "box"),
    ListData(title: "Barril", description: "de 55 galones con comida y/o ropa usada", price: "$125", icon: "drum_55"),
    ListData(title: "Barril", description: "de 77 galones con comida y/o ropa usada", price: "$150", icon: "drum_77"),
    ListData(title: "TV", description: "de 32 pulgada", price: "$192", icon: "tv"),
    ListData(title: "TV", description: "de 36 pulgada", price: "$216", icon: "tv"),
    ListData(title: "TV", description: "de 42 pulgada", price: "$252", icon: "tv"),
    ListData(title: "TV", description: "de 43 pulgada", price: "$387", icon: "tv"),
    ListData(title: "TV", description: "de 50 pulgada", price: "$470", icon: "tv"),
    ListData(title: "TV", description: "de 55 pulgada", price: "$495", icon: "tv"),
    ListData(title: "TV", description: "de 65 pulgada", price: "$585", icon: "tv"),
    ListData(title: "TV", description: "de 75 pulgada", price: "$675", icon: "tv"),
    ListData(title: "Furniture", description: "Mattress twin", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mattress y base twin", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mattress queen", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mattress y base queen", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mattress king", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mattress y base king", price: "85", icon: "furniture"),
    ListData(title: "Furniture", description: "Mueble de 1 asiento", price: "150+", icon: "furniture"),
    ListData(title: "Furniture", description: "Mueble de 2 asientos", price: "300+", icon: "furniture"),
    ListData(title: "Furniture", description: "Mueble de 3 asientos", price: "450+", icon: "furniture"),
    ListData(title: "Furniture", description: "Silla de rueda cerrada", price: "60", icon: "furniture"),
    ListData(title: "Furniture", description: "Silla de rueda electrica", price: "150", icon: "furniture"),
    ListData(title: "Appliance", description: "Lavadora", price: "250+", icon: "appliance"),
    ListData(title: "Appliance", description: "Secadora", price: "250+", icon: "appliance"),
    ListData(title: "Appliance", description: "Nevera con puerta arriba y abajo", price: "350+", icon: "appliance"),
    ListData(title: "Appliance", description: "Nevera con 2 puerta arriba y 1 abajo", price: "500+", icon: "appliance"),
    ListData(title: "Appliance", description: "Estufa", price: "250+", icon: "appliance"),
]

struct RatesView: View {
    
    var title : String
    
    @State var d = data
    
    var body: some View {
            VStack(alignment: .leading){
                ScrollView{
                    ForEach(d, id: \.self) { m in
                        RatesRow(image: m.icon, title: m.title, description: m.description, price: m.price)
                        Spacer()
                    }
                }
                .padding(0)
                HStack(alignment: .center){
                    Image("whatsapp")
                        .resizable()
                        .frame(width: 60, height: 40, alignment: .center)
                        .padding(.vertical, 5.0)
                    Text("For more prices, send images to our WhatsApp")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 2.0)
                }
                .frame(width: screenWidth)
                .border(Color.accent, width: 1)
            }
            .padding(.top)
    }
}

struct RatesRow: View {
    
    var image: String
    var title: String
    var description: String
    var price: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            HStack {
                ZStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                    
                    Text(description)
                        .padding(.bottom, 5)
                    
                }
                .padding(.horizontal, 5)
                Spacer()
                HStack {
                    PricePill(price: price)
                }
            }
            .padding(10)
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
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
