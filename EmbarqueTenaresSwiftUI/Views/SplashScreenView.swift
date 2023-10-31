import SwiftUI

struct SplashScreenView: View {
    
    let fonts = Fonts()
    
    @State var animationValues: [Bool] = Array(repeating: false, count: 10)
    
    
    var body: some View {
        ZStack{
            Color.light.ignoresSafeArea()
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth/1.25, alignment: .center)
                    .scaleEffect(animationValues[0] ? 1 : 4, anchor: .center)
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
