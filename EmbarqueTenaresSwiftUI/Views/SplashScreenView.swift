import SwiftUI

struct SplashScreenView: View {
    
    let fonts = Fonts()
    let imageName : String = "logo"
    @State var animationValues: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        ZStack{
            Color.light.ignoresSafeArea()
            VStack{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth/1.25)
                    .scaleEffect(animationValues[0] ? 1 : 4)
                    .offset(y: -25)
            }
            MainView()
                .environment(\.colorScheme, .light)
                .opacity(animationValues[1] ? 1 : 0)
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.linear(duration: 1)){
                    animationValues[0] = true
                }
                
                withAnimation(.easeInOut(duration: 1).delay(1)){
                    animationValues[1] = true
                }
                
            }
        }
    }
}
