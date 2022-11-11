import Foundation
import SwiftUI

struct RatesView: View {
    @Binding var lang: String
    @StateObject var ratesViewModel = RatesViewModel()
    
    let whatsapp : LocalizedStringKey = "whatsapp"
    let rates : LocalizedStringKey = "rates"
    
    func openWhatsapp(){
        @Environment(\.openURL) var openURL
        
        if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
            openURL(url)
        }
    }
    
    // LOCALE CHANGE LOGIC
    var body: some View {
        ZStack{
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
                        }.frame(maxWidth: .infinity)
                        .listStyle(.plain)
                    }
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
                    }
                    .frame(width: screenWidth)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.accent, lineWidth: 1.5)
                    )
                    .onTapGesture{
                        openWhatsapp()
                    }
                }
            }
        }
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
