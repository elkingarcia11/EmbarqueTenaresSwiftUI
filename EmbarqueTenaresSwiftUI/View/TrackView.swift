import SwiftUI
import Foundation

// get eta time from db
struct TrackView: View {
    @Binding var title: LocalizedStringKey
    @Binding var lang: String
    @Binding var shouldReset: Bool
    
    let edoa : LocalizedStringKey = "edoa"
    let invoice : LocalizedStringKey = "invoice"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    
    @State private var finalText : String = ""
    @State private var text : String = ""
    @StateObject var trackViewModel = TrackViewModel()
    
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
                        Spacer()
                        Text(edoa)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                        HStack {
                            Text(invoice)
                                .font(.title2)
                            Text(finalText)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.bottom)
                        
                        if lang == "es"{
                            Text(trackViewModel.arrivalDate_es)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom)
                        } else {
                            Text(trackViewModel.arrivalDate_en)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                        }
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
                                .onSubmit {
                                    title = "track"
                                    Task {
                                        do {
                                            await trackViewModel.resetVars()
                                            try await trackViewModel.login()
                                            try await trackViewModel.getETA(invoiceNumber: self.text)
                                            self.finalText = self.text
                                        } catch {
                                            trackViewModel.state = .failed
                                            trackViewModel.errorMsg = error.localizedDescription
                                        }
                                    }
                                }
                        
                    }
                    .background(Color.white)
                    .frame(width: screenWidth)
                }
            }
        }
        .onChange(of: shouldReset) {
            newValue in
            self.shouldReset = false
            self.text = ""
            self.finalText = ""
            Task {
                await trackViewModel.resetVars()
            }
        }
    }
        
}

