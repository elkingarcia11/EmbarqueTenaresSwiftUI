import SwiftUI

struct ErrorView : View {
    @State var error : LocalizedStringKey
    
    init(errorMsg : String){
        error = LocalizedStringKey(errorMsg)
    }
    
    var body : some View {
        VStack{
            Spacer()
            Text("ERROR")
                .font(.title)
                .padding(.bottom)
            HStack(alignment: .center){
                Text(error).font(.subheadline).multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
