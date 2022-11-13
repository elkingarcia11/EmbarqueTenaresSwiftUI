import Foundation
import SwiftUI

struct LocationsView: View {
    var body: some View {
        ZStack{
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
