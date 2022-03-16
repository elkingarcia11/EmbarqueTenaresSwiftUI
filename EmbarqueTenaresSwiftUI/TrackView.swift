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
    
    @State var progressValue: Float = 12/25
    
    @State var deliveryTime: Int = 20
    
    @State var daysLeft: Int = 13
    
    @State var searchStatus = -1
    
    @State private var text = ""
    
    @State var originalDate : String = "2022-02-14"
    
    @State var arrivalDate : String = ""
    
    @State var error_1 : String = ""
    @State var error_2 : String = ""
    
    let track : LocalizedStringKey = "track"
    let edoa : LocalizedStringKey = "edoa"
    let etaFootnote : LocalizedStringKey = "etaFootnote"
    let search : LocalizedStringKey = "search"
    let errorMsg1 : LocalizedStringKey = "errorMsg1"
    let errorMsg2 : LocalizedStringKey = "errorMsg2"
    
    func getInvoiceStatus(invoice : String) -> Int {
        // IF invoice is number only && > 0
        if let i = Int(text) {
            if i > 0 {
                // GET DATE OF INVOICE FROM DB
                // IF SUCCESS && INVOICE EXIST,
                    // ogDate = invoice.date
                    // get delivery time
                    // IF SUCCESS && DELIVERY TIME EXISTS
                    // ELSE THROW ERROR
                // ELSE THROW ERROR
                
                // if connection good // db returns item
                // retrieve date from item "FORMAT: YYYY-MM-DD
                // ELSE THROW ERROR
                // THROW INVALID INVOICE
                // retrieve delivery time FROM DB
                // if deliver time valid // connection good
                // ADD ETA TO ORIGINAL DATE TO GET FINAL DATE
                // SUBTRACT FINAL DATE FROM ORIGINAL DATE TO GET DAYS LEFT
                // ELSE THROW ERROR
                // Retrieve OG DATE STRING FROM DB
                
                // TURN DATESTRING INTO DATE OBJECT
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd"
                if let ogDate = dateFormatter.date(from:originalDate) {
                    // CALCULATE ARRIVAL DATE
                    if let arrDate = Calendar.current.date(byAdding: .day, value: deliveryTime, to: ogDate) {
                        // TURN ARRIVAL DATE INTO STRING TO PRESENT IN VIEW
                        let stringFormatter = DateFormatter()
                        stringFormatter.dateStyle = .long
                        stringFormatter.timeStyle = .none
                        arrivalDate = stringFormatter.string(from: arrDate)
                        
                        // IF ARRIVAL DATE IS > TODAYS DATE
                        // GET HO WMANY DAYS LEFT
                        // IF ARRIVAL DATE IS < TODAYS DATE
                        // 0 DAYS LEFT -> DELIVERED
                        // IF ARRIVAL DATE IS = TODAYS DATE
                        // 1 DAY LEFT
                        daysLeft = Int(Date().distance(to: arrDate))/60/60/24+1
                        if daysLeft <= 0 {
                            progressValue = 1
                            daysLeft = 0
                        } else {
                            progressValue = Float(1-(Float(daysLeft)/Float(deliveryTime)))
                        }
                        
                        return 1
                    } else{
                        //throw error
                        error_1 = "There was an issue calculating the date of arrival. Please call the office for more information."
                        text = ""
                        error_2 = ""
                        return -2
                    }
                } else {
                    // throw error
                    error_1 = "There was an issue calculating the date of arrival. Please call the office for more information."
                    text = ""
                    error_2 = ""
                    return -2
                }
            } else {
                // throw error
                error_1 = "Invoice is invalid. Please try again."
                text = ""
                error_2 = ""
                return -2
            }
        } else {
            // throw error
            error_1 = "Invoice is invalid. Please try again."
            text = ""
            error_2 = ""
            return -2
        }
    }
    
    var body: some View {
        ZStack {
            VStack{
                if searchStatus == 1 {
                    Spacer()
                    Text(edoa)
                        .font(.title)
                        .padding(.bottom)
                    Text(arrivalDate)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    ProgressBar(progress: self.$progressValue, daysLeft: daysLeft)
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    Spacer()
                    Text(etaFootnote)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing])
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
