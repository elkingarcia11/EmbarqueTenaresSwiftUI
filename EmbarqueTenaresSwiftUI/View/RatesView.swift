import Foundation
import SwiftUI

struct RatesView: View {
    @Binding var lang: String
    @StateObject var ratesViewModel = RatesViewModel()
    
    let whatsapp : LocalizedStringKey = "whatsapp"
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.light
            if ratesViewModel.isLoading{
                VStack{
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
                    Spacer()
                }
            } else {
                VStack(alignment: .leading, spacing: 0){
                    if ratesViewModel.statusCode == -1 {
                        ErrorView(errorMsg: ratesViewModel.errorMsg)
                    } else {
                        List {
                            ForEach(ratesViewModel.catsAndItems) { catAndItem in
                                CollapsibleView(image: catAndItem.category.name_en, label: lang == "en" ? catAndItem.category.name_en :catAndItem.category.name_es){
                                    ForEach(catAndItem.items) { item in
                                        Divider()
                                        HStack(alignment: .center){
                                            Text(lang == "en" ? item.name_en : item.name_es)
                                                .padding(.horizontal)
                                            Spacer()
                                            PricePillView(price: item.price)
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
                FABView(text: whatsapp, image: "whatsapp")
            }
        } // ZStack
    }
}
