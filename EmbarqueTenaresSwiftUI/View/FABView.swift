import Foundation
import SwiftUI

struct FABView : View {
    @Environment(\.openURL) private var openURL
    @State var text  : LocalizedStringKey
    @State var image : String
    
    func openWhatsapp(){
        
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
                    Image(image)
                    .resizable()
                    .frame(width: 50, height:50)
                    .clipShape(Circle())
            }
            .shadow(color:  Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            .padding()
        } //body
    }
}
