import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Float
    @State var daysLeft: Int
    let daysL : LocalizedStringKey = "daysLeft"
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(daysLeft == 0 ? Color(UIColor.systemGreen) : Color.primary)
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(daysLeft == 0 ? Color(UIColor.systemGreen) : Color.primary)
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            VStack{
                Text("\(daysLeft)")
                    .font(.title)
                    .bold()
                    .foregroundColor(daysLeft == 0 ? Color(UIColor.systemGreen) : Color.primary)
                Text(daysL)
                    .font(.title2)
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity)
    }
}

