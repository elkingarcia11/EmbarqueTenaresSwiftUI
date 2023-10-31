import SwiftUI

struct CollapsibleRowView : View {
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
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: self.collapsed ? "chevron.right" : "chevron.down")
                            .padding(.trailing)
                            .frame(width: screenWidth/15)
                            .foregroundColor(Color.accent)
                    }
                    .background(Color.light)
                }
            )
            .buttonStyle(PlainButtonStyle())
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text(self.answer)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(minWidth: screenWidth)
                }
                .frame(minWidth: screenWidth)
            }
            .background(Color.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
