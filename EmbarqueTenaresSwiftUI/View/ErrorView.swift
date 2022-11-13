import SwiftUI
import AVKit

struct ErrorView : View {
    @State var error : LocalizedStringKey
    @State var player = AVPlayer()
    
    init(errorMsg : String){
        error = LocalizedStringKey(errorMsg)
    }
    
    var body : some View {
        VStack{
            Spacer()
            
            Text("Error")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.bottom, 2.0)
            
            Image("sad_error")
                .resizable()
                .padding(.vertical)
                .scaledToFit()
                .frame(width: 125, height: 125)
            
            HStack(alignment: .center){
                Text(error).font(.subheadline).fontWeight(.semibold).multilineTextAlignment(.center)
            }
            .padding([.top, .leading, .trailing], 5.0)
            
            Spacer()
        }
    }
}
