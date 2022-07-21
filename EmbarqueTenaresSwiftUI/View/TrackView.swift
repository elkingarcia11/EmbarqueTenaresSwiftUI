//
//  TrackViewTwo.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 3/14/22.
//

import SwiftUI
import Foundation

// get eta time from db
struct TrackView: View {
    @Binding var lang: String
    @Binding var shouldReset: Bool
    
    @State var title : LocalizedStringKey = ""
    let empty : LocalizedStringKey = ""
    let track : LocalizedStringKey = "track"
    let edoa : LocalizedStringKey = "edoa"
    let invoice : LocalizedStringKey = "invoice"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    
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
                            Text(text)
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
                        ProgressBar(progress: $trackViewModel.progressValue, daysLeft: trackViewModel.daysLeft)
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
                                    Task {
                                        do {
                                            await trackViewModel.resetVars()
                                            try await trackViewModel.login()
                                            try await trackViewModel.getETA(invoiceNumber: self.text)
                                            self.title = track
                                        } catch {
                                            trackViewModel.state = .failed
                                            trackViewModel.errorMsg = error.localizedDescription
                                            self.title = empty
                                        }
                                    }
                                }
                        
                    }
                    .background(Color.white)
                    .frame(width: screenWidth)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(title)
        .onChange(of: shouldReset) {
            newValue in
            self.shouldReset = false
            self.text = ""
            self.title = empty
            Task {
                await trackViewModel.resetVars()
            }
        }
    }
        
}

struct ProgressBar: View {
    @Binding var progress: Float
    @State var daysLeft: Int
    let daysL : LocalizedStringKey = "daysLeft"
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.primary)
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.primary)
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: screenWidth*0.5, height: screenWidth*0.5)
            VStack{
                Text("\(daysLeft)")
                    .font(.title)
                    .bold()
                Text(daysL)
                    .font(.title2)
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity)
    }
}
