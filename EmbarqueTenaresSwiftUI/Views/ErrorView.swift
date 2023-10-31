import SwiftUI

struct ErrorView : View {
    @State var error : LocalizedStringKey
    
    init(errorMsg : String){
        error = LocalizedStringKey(errorMsg)
    }
    
    var body : some View {
        VStack{
            Spacer()
            VStack{
                Text("Error")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.vertical)
                
                Image(systemName: "xmark.octagon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.gray)
                
                HStack(alignment: .center){
                    Text(error).font(.subheadline).fontWeight(.semibold).multilineTextAlignment(.center)
                }
                .padding(.all)
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
            Spacer()
        }
    }
}
