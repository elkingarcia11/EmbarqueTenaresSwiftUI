import Foundation
import SwiftUI

struct FABView : View {
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
                VStack(alignment: .center){
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    Text(text)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .frame(width: 100)
                        .foregroundColor(.white)
                    
                }
                .padding(.vertical)
            }
            .background(Color.whatsappGreen)
            .foregroundColor(.black)
            .cornerRadius(25)
            .shadow(color:  Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            .padding()
        } //body
    }
}
