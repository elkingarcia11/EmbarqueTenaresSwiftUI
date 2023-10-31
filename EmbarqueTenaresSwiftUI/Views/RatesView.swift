import Foundation
import SwiftUI

struct RatesView: View {
    @Binding var lang: String
    @StateObject var ratesViewModel = RatesViewModel()
    
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
                            ForEach(ratesViewModel.categories) { category in
                                CollapsibleView(image: category.name_en, label: lang == "en" ? category.name_en : category.name_es){
                                    ForEach(category.items ?? []) { item in
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
                FABView(image: "whatsapp")
            }
        } // ZStack
    }
}
