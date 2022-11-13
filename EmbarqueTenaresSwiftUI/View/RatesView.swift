import Foundation
import SwiftUI

struct RatesView: View {
    @Binding var lang: String
    @StateObject var ratesViewModel = RatesViewModel()
    
    let whatsapp : LocalizedStringKey = "whatsapp"
    let rates : LocalizedStringKey = "rates"
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.light
            if ratesViewModel.isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            } else {
                VStack(alignment: .leading, spacing: 0){
                    if ratesViewModel.statusCode == -1 {
                        ErrorView(errorMsg: ratesViewModel.errorMsg)
                    } else {
                            List {
                                ForEach(ratesViewModel.catsAndItems) { catAndItem in
                                    Collapsible(image: catAndItem.category.name_en, label: lang == "en" ? catAndItem.category.name_en :catAndItem.category.name_es){
                                        ForEach(catAndItem.items) { item in
                                            Divider()
                                            HStack(alignment: .center){
                                                Text(lang == "en" ? item.name_en : item.name_es)
                                                    .padding(.horizontal)
                                                Spacer()
                                                PricePill(price: item.price)
                                                    .padding(.horizontal)
                                            }
                                            .frame(width: screenWidth)
                                            .padding(.vertical)
                                        }
                                    }
                                }
                            }
                            .frame(width: screenWidth, height: (screenHeight/1.25))
                            .listStyle(.plain)
                        
                    }
                } // VStack
                
            FAB(text: whatsapp, image:
                    "whatsapp")
            }
        } // ZStack
    }
}

struct FAB : View {
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
                                .fontWeight(.semibold)
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
                    .cornerRadius(.infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.lightDark, lineWidth: 2)
                    )
                    .padding()
        } //body
        
    }
}
struct Collapsible<Content: View>: View {
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
