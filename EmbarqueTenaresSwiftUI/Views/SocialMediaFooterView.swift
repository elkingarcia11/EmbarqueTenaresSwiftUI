import Foundation
import SwiftUI

/// A SwiftUI view representing a social media footer with buttons to open WhatsApp, Facebook, and Instagram links.
struct SocialMediaFooterView : View{
    /// The environment variable for opening URLs, provided by SwiftUI.
    @Environment(\.openURL) var openURL
    
    
    /// Opens the corresponding link based on the given index.
    ///
    /// - Parameter index: The index of the social media platform to open. Use 0 for WhatsApp, 1 for Facebook, and 2 for Instagram.
    func openLink(index : Int) {
        switch index {
        case 0:
            openURLIfPossible("https://api.whatsapp.com/send?phone=17185621300")
        case 1:
            openFacebookProfile()
        case 2:
            openURLIfPossible("https://instagram.com/embarquetenares")
        default:
            break
        }
    }
    
    /// Opens a URL if it can be created from the provided string.
    ///
    /// - Parameter urlString: The URL string to open.
    func openURLIfPossible(_ urlString: String) {
        if let url = URL(string: urlString) {
            openURL(url)
        }
    }
    
    /// Opens the Facebook profile using the Facebook app if available, or falls back to a web URL.
    func openFacebookProfile() {
        if let url = URL(string: "fb://profile?id=embarquetenaress") {
            openURL(url) { accepted in
                if !accepted {
                    openURLIfPossible("https://www.facebook.com/EmbarqueTenaress/")
                }
            }
        } else {
            openURLIfPossible("https://www.facebook.com/EmbarqueTenaress/")
        }
    }
    
    var body: some View{
        HStack {
            Spacer()
            SocialMediaButton(imageName: "whatsapp", size: 65) {
                openLink(index: 0)
            }
            Spacer()
            SocialMediaButton(imageName: "facebook", size: 50) {
                openLink(index: 1)
            }
            Spacer()
            SocialMediaButton(imageName: "instagram", size: 50) {
                openLink(index: 2)
            }
            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            alignment: .center
        )
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }}
