import Foundation
import SwiftUI

struct FAQsView: View {
    
    @StateObject var faqsViewModel = FAQsViewModel()
    @Binding var lang: String
    
    var body: some View {
        ZStack{
            Color.light
            if faqsViewModel.isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if faqsViewModel.statusCode == -1 {
                    ErrorView(errorMsg: faqsViewModel.errorMsg)
                } else {
                    VStack(spacing: 0){
                        List{
                            if lang == "es" {
                                ForEach(faqsViewModel.faqs_es){ faq in
                                    CollapsibleRowView(
                                        question: faq.q,
                                        answer: faq.a
                                    )
                                    .listRowBackground(Color.white)
                                    .frame(width: screenWidth)
                                }
                            } else {
                                ForEach(faqsViewModel.faqs_en){ faq in
                                    CollapsibleRowView(
                                        question: faq.q,
                                        answer: faq.a
                                    )
                                    .frame(width: screenWidth)
                                }
                            }
                        }
                        .frame(width: screenWidth, height: screenHeight/1.25)
                        .listStyle(.plain)
                    }
                    .padding()
                }
            }
        }
        .background(Color.blue)
        .frame(width: screenWidth, height: screenHeight)
    }
}

struct FAQsView_Previews: PreviewProvider {
    static var previews : some View {
        FAQsView(lang: .constant("en"))
    }
}
