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
    
    let track : LocalizedStringKey = "track"
    let edoa : LocalizedStringKey = "edoa"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    
    @State private var text = ""
    @StateObject var trackViewModel = TrackViewModel()
    
    
    var body: some View {
        ZStack {
            VStack{
                if trackViewModel.isLoading{
                    Spacer()
                    ProgressView()
                        .padding(.top)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(3)
                } else{
                    if trackViewModel.searchStatus == -2 {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth/1.25, alignment: .center)
                    }
                    if trackViewModel.searchStatus == 1 {
                        Spacer()
                        Text(edoa)
                            .font(.title)
                            .padding(.bottom)
                        Text(trackViewModel.arrivalDate)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        ProgressBar(progress: $trackViewModel.progressValue, daysLeft: trackViewModel.daysLeft)
                            .frame(width: 150.0, height: 150.0)
                            .padding(40.0)
                        Spacer()
                        Text(etaFootnote)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding([.leading, .bottom, .trailing])
                        Spacer()
                    }
                    if trackViewModel.searchStatus == -1 {
                        ErrorView(errorMsg: trackViewModel.errorMsg)
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(search, text: $text)
                        .onSubmit {
                            trackViewModel.getETA(invoice: text)
                        }
                }
                .padding(.all)
                .background(Color.light)
                .frame(width: screenWidth)
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



