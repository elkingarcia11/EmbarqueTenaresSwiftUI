//
//  TrackViewTwo.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 3/14/22.
//

import SwiftUI

// get eta time from db
struct TrackView: View {
    
    @State var eta: Float = 25
    @State var progressValue: Float = 12/25
    @State var daysLeft: Int = 13
    
    @State var searchStatus = -1
    
    @State private var text = ""
    
    
    let track : LocalizedStringKey = "track"
    let edoa : LocalizedStringKey = "edoa"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    let errorMsg1 : LocalizedStringKey = "errorMsg1"
    let errorMsg2 : LocalizedStringKey = "errorMsg2"
    
    func getInvoiceStatus(invoice : String) -> Int {
        return 1
    }
    
    /*
     @State var daysElapsed: Float
     @State var dateOfInvoice: String
     @State var todaysDate: String
     */
    /*
     init() {
     // get eta from db
     eta = 25
     // get date of invoice from db
     dateOfInvoice = "2022-2-20"
     
     // get today's date
     
     // calculate difference in days
     
     // date of invoice should be less then or equal to todays date - > so smallest number 0, largest number is anything over eta >, which would indicate deliverd
     }
     // calculate days between today and date of invoice and put it over eta from db to get time left as decimal*/
    //progressValue = 1/25
    
    
    var body: some View {
        ZStack {
            VStack{
                if searchStatus == 1 {
                    Spacer()
                    Text(edoa)
                        .font(.title)
                        .padding(.bottom)
                    Text("December 3rd, 2022")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    ProgressBar(progress: self.$progressValue, daysLeft: daysLeft)
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    Spacer()
                    Text(etaFootnote)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Spacer()
                }
                
            if searchStatus == -1 {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth/1.25, alignment: .center)
            }
            if searchStatus == -2 {
                Spacer()
                Text("ERROR")
                    .font(.title)
                    .padding(.bottom)
                HStack(alignment: .center){
                    Text(errorMsg1).font(.subheadline)
                    Text(text).bold().font(.subheadline)
                    Text(errorMsg2).font(.subheadline)
                }
                Spacer()
            }
            Spacer()
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(search, text: $text)
                    .onSubmit {
                        searchStatus = getInvoiceStatus(invoice: text)
                    }
            }
            .padding(.all)
            .background(Color.light)
            .frame(width: screenWidth)
            }
        }
    }
    
    func incrementProgress() {
        let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
        self.progressValue += randomValue
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
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.primary)
                .rotationEffect(Angle(degrees: 270.0))
            VStack{
                Text("\(daysLeft)")
                    .font(.title)
                    .bold()
                Text(daysL)
                    .font(.title2)
                
            }
        }
    }
}
