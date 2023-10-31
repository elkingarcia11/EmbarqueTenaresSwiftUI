import SwiftUI

struct PricePillView: View {
    
    var price: String
    
    var body: some View {
        ZStack {
            Text(price)
                .font(.system(size: 20.0, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.primary)
                .cornerRadius(5)
        }
    }
}

