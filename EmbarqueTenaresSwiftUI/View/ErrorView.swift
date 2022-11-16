import SwiftUI

struct ErrorView : View {
    @State var error : LocalizedStringKey
    
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
                .padding(.bottom)
            
            Image("sad_error")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
            
            HStack(alignment: .center){
                Text(error).font(.subheadline).fontWeight(.semibold).multilineTextAlignment(.center)
            }
            .padding([.top, .leading, .trailing])
            
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews : some View {
        ErrorView(errorMsg: "This is my error message.This is my error message.This is my error message.This is my error message.This is my error message.This is my error message.This is my error message.")
    }
}
