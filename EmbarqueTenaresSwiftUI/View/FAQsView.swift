import Foundation
import SwiftUI

struct FAQsView: View {
    
    @StateObject var faqsViewModel = FAQsViewModel()
    @Binding var lang: String
    
    var body: some View {
        ZStack{
            if faqsViewModel.isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if faqsViewModel.statusCode == -1 {
                    ErrorView(errorMsg: faqsViewModel.errorMsg)
                } else {
                    ScrollView{
                        VStack(spacing: 0) {
                            if lang == "es" {
                                ForEach(faqsViewModel.faqs_es){ faq in
                                    CollapsibleRow(
                                        question: faq.q,
                                        answer: faq.a
                                    )
                                    .frame(maxWidth: .infinity)
                                }
                            } else {
                                ForEach(faqsViewModel.faqs_en){ faq in
                                    CollapsibleRow(
                                        question: faq.q,
                                        answer: faq.a
                                    )
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .listStyle(.plain)
                    }
                }
            }
        }
    }
}

struct CollapsibleRow : View {
    @State var question: String
    @State var answer: String
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack(alignment: .center) {
                        Text(self.question)
                            .padding(.all)
                        
                        Spacer(minLength: 0)
                        Image(systemName: self.collapsed ? "chevron.right" : "chevron.down")
                            .padding(.trailing)
                            .frame(width: screenWidth/15)
                            .foregroundColor(Color.accent)
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            VStack {
                HStack {
                    Text(self.answer)
                        .padding(.all)
                }
                .frame(maxWidth: .infinity)
                .background(Color.light)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
        }
    }
}
