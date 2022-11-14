import Foundation
import SwiftUI

struct LocationsView: View {
    var body: some View {
        ZStack{
            Color.light
            VStack(alignment: .leading) {
                ScrollView{
                    NewYorkLocationView()
                    Divider()
                    DrLocationView()
                }
                SocialMediaFooterView()
            }
        }
    }
}

struct Location_Previews: PreviewProvider {
    static var previews : some View {
        LocationsView()
    }
}
