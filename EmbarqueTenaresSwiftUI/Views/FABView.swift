import SwiftUI

/// A SwiftUI view representing a Floating Action Button (FAB) that opens WhatsApp when tapped.
struct FABView : View {
    
    /// The environment variable for opening URLs, provided by SwiftUI.
    @Environment(\.openURL) private var openURL
    
    /// The name of the image to display on the FAB.
    let image : String
    
    /// Opens the WhatsApp URL when the FAB is tapped.
    func openWhatsapp(){
        // Create a URL for opening WhatsApp with a predefined phone number.
        if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
            // Use the openURL environment variable to open the URL.
            openURL(url)
        }
    }
    
    var body: some View {
        HStack{
            Spacer()
            
            // Create a button that triggers the openWhatsapp function when tapped.
            Button(action: {
                openWhatsapp()
            }) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65, height: 65)
            }
            // Apply a shadow effect to the button.
            .shadow(color:  Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            .padding([.bottom, .trailing], 25.0)
        }
    }
}
