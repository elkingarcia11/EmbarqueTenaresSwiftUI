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
                                    CollapsibleRow(
                                        question: faq.q,
                                        answer: faq.a
                                    )
                                    .listRowBackground(Color.white)
                                    .frame(width: screenWidth)
                                }
                            } else {
                                ForEach(faqsViewModel.faqs_en){ faq in
                                    CollapsibleRow(
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

struct CollapsibleRow : View {
    @State var question: String
    @State var answer: String
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack(alignment: .center, spacing: 0) {
                        Text(self.question)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: self.collapsed ? "chevron.right" : "chevron.down")
                            .padding(.trailing)
                            .frame(width: screenWidth/15)
                            .foregroundColor(Color.accent)
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text(self.answer)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(minWidth: screenWidth)
                }
                .frame(minWidth: screenWidth)
            }
            .background(Color.light)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
