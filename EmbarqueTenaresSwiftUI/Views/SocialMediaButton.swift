import SwiftUI

struct SocialMediaButton: View {
    let imageName: String
    let size: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
        .shadow(color: Color(UIColor.lightGray), radius: 2, x: 3, y: 3)
        .padding(.vertical, 10)
    }
}

/*
struct SocialMediaButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaButton()
    }
}
*/
