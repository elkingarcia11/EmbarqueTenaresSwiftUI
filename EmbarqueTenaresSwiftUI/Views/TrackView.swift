import SwiftUI

struct TrackView: View {
    @Binding var title: LocalizedStringKey
    @Binding var lang: String
    @Binding var resetScreen: Bool
    
    @State private var finalText : String = ""
    @State private var text : String = ""
    
    @StateObject var trackViewModel = TrackViewModel()
    
    @EnvironmentObject var httpHeader: HttpHeader
    
    @FocusState private var isFocused: Bool
    
    let edoa : LocalizedStringKey = "edoa"
    let invoice : LocalizedStringKey = "invoice"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    
    var body: some View {
        ZStack {
            Color.light
            VStack{
                if trackViewModel.state == .loading {
                    Spacer()
                    ProgressView()
                        .padding(.top)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(3)
                } else {
                    if trackViewModel.state == .na {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth/1.25, alignment: .center)
                    } else if trackViewModel.state == .successful {
                        Text(edoa)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical)
                        if lang == "es"{
                            Text(trackViewModel.arrivalDate_es)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.top)
                        } else {
                            Text(trackViewModel.arrivalDate_en)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.top)
                        }
                        Spacer()
                        HStack {
                            Text(invoice)
                                .font(.title2)
                            Text(finalText)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.bottom)
                        
                       
                        ProgressBarView(progress: $trackViewModel.progressValue, daysLeft: trackViewModel.daysLeft)
                            .frame(width: 150.0, height: 150.0)
                            .padding(40.0)
                        Spacer()
                        Text(etaFootnote)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding([.leading, .bottom, .trailing], 20.0)
                        Spacer()
                    } else if trackViewModel.state == .failed {
                        ErrorView(errorMsg: trackViewModel.errorMsg)
                    }
                }
                Spacer()
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(.systemGray3))
                            .padding([.top, .leading, .bottom])
                        TextField(search, text: $text)
                            .padding(.vertical)
                            .disableAutocorrection(true)
                            .focused($isFocused)
                            .onSubmit {
                                title = "track"
                                Task{
                                    await trackViewModel.submitInvoice(invoice: self.text, httpHeader: httpHeader)
                                }
                            }
                    }
                    .background(Color.white)
                    .frame(width: screenWidth)
                }
            }
        }
        .onTapGesture {
            isFocused.toggle()
        }
        .onChange(of: resetScreen) {
            newValue in
            self.text = ""
            self.finalText = ""
            trackViewModel.resetVars()
            self.resetScreen.toggle()
        }
    }
    
}

