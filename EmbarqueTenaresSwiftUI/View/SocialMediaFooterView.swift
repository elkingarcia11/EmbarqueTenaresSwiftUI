import Foundation
import SwiftUI

struct SocialMediaFooterView : View{
    
    @Environment(\.openURL) var openURL
    
    /*
    let whatsapp = UIImage(named: "whatsapp")
    let facebook = UIImage(named: "facebook")
    let instagram = UIImage(named: "instagram")
    
    // Define the desired size for all images
    let targetSize = CGSize(width: 50, height: 50)
    
    // Function to resize an image
    func resizeImage(_ image: UIImage?, toSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image?.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    // Resize each image to the desired size
    let resizedImage1 = resizeImage(image1, toSize: targetSize)
    let resizedImage2 = resizeImage(image2, toSize: targetSize)
    let resizedImage3 = resizeImage(image3, toSize: targetSize)

    */
    func openLink(index : Int) {
        if index == 0 {
            if let url = URL(string: "https://api.whatsapp.com/send?phone=17185621300") {
                openURL(url)
            }
        } else if index == 1 {
            if let url = URL(string: "fb://profile?id=embarquetenaress") {
                openURL(url) { accepted in
                    let _ = accepted ? () : tryBackUpLink()
                }
            }
        } else if index == 2 {
            if let url = URL(string: "https://instagram.com/embarquetenares") {
                openURL(url)
            }
        }
    }
    
    func tryBackUpLink() {
        if let url = URL(string: "https://www.facebook.com/EmbarqueTenaress/") {
            openURL(url)
        }
    }
    
    var body: some View{
        HStack {
            Spacer()
            Button(action: {openLink(index: 0)}) {
                Image("whatsapp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .shadow(color: Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            Spacer()
            Button(action: {openLink(index: 1)}) {
                Image("facebook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .shadow(color: Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            Spacer()
            Button(action: {openLink(index: 2)}) {
                Image("instagram")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .shadow(color: Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
}
