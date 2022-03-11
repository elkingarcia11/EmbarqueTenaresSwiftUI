//
//  TrackView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI


struct TrackView: View {    @State var tracking = false
    @State var isPresented = false
    @State var popUpTitle = ""
    @State var popUpMessage = ""
    @State private var text = ""
    
    @State private var finalInvoice = ""
    
    @State var eta: Int = -1
    
    @State var showPopUp = false
    
    func getInvoiceStatus(invoice : String) -> Int {
        // Fetch invoice
        // RETURN int representing status
        /**
         RANK OF ETAS:
         -2 - invoice doesn't exist
         0 - ALM-NY / DEV-NY
         1 - EN TRANSITO
         2 - ALM-RD / DEV-RD
         3 - CONDUCE
         4 - ENTREGADO
         */
        
        //18-30 days
        // alm ny 1-3 days
        // en transito 4-19
        // rd 2-4 days
        // conduce 1-2 days
        // if entregado
        let newInv = invoice.filter{ Set("0123456789").contains($0) }
        finalInvoice = newInv
        if let r = Int(finalInvoice) {
            return r
        } else {
            return -2
        }
    }
    
    func togglePopUp(index : Int) {
        switch index {
        case 0:
            popUpTitle = "Almacen NY"
            popUpMessage = "The shipment is currently at our New York warehouse. Estimated days left: 21 to 25 days (Time will vary depending on the season)"
        case 1:
            popUpTitle = "Enviado"
            popUpMessage = "The shipment is on its way to the Dominican Republic. Estimated days left: 4 to 20 days (Time will vary depending on the season)"
        case 2:
            popUpTitle = "Almacen RD"
            popUpMessage = "The shipment is currently at our Dominican Republic warehouse. Estimated days left: 2 to 4 days (Time will vary depending on the season)"
        case 3:
            popUpTitle = "Entregando"
            popUpMessage = "The shipment is currently being delivered to your Dominican Republic address. Estimated days left: 0 to 2 days (Time will vary depending on the season)"
        case 4:
            popUpTitle = "Entregado"
            popUpMessage = "The shipment has been delivered to your Dominican Republic Address. Thank you for choosing and trusting us!"
        default:
            print("")
            
        }
        
        isPresented.toggle()
    }
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .center) {
                VStack{
                    if tracking {
                        Text("Track Invoice")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding()
                    } else {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth/1.25, alignment: .center)
                    }
                    
                        
                    if eta > -1 {
                        Spacer()
                        VStack(alignment: .center){
                            Text(finalInvoice)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(Color.positive)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(25)
                            VStack{
                                HStack{
                                    ExDivider()
                                }
                                Button("Almacen NY", action: {
                                    togglePopUp(index: 0)
                                })
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.subheadline)
                                    .frame(width: screenWidth/2, height: screenHeight/16)
                                    .background(Color.primary)
                                    .cornerRadius(25)
                                    .disabled(eta == 0 ? false : true)
                                
                                HStack{
                                    ExDivider()
                                }
                                Button("Enviado", action: {
                                    togglePopUp(index: 1)
                                })
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.subheadline)
                                    .frame(width: screenWidth/2, height: screenHeight/16)
                                    .background(eta > 0 ? Color.primary : Color.gray)
                                    .cornerRadius(25)
                                    .disabled(eta == 1 ? false : true)
                                
                                HStack{
                                    ExDivider()
                                }
                                Button("Almacen RD", action: {
                                    togglePopUp(index: 2)
                                })
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.subheadline)
                                    .frame(width: screenWidth/2, height: screenHeight/16)
                                    .background(eta > 1 ? Color.primary : Color.gray)
                                    .cornerRadius(25)
                                    .disabled(eta == 2 ? false : true)
                                
                                HStack{
                                    ExDivider()
                                }
                                Button("Entregando", action: {
                                    togglePopUp(index: 3)
                                })
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.subheadline)
                                    .frame(width: screenWidth/2, height: screenHeight/16)
                                    .background(eta > 2 ? Color.primary : Color.gray)
                                    .cornerRadius(25)
                                    .disabled(eta == 3 ? false : true)
                                HStack{
                                    ExDivider()
                                }
                                
                                Button("Entregado", action: {
                                    togglePopUp(index: 4)
                                })
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.subheadline)
                                    .frame(width: screenWidth/2, height: screenHeight/16)
                                    .background(eta > 3 ? Color.primary : Color.gray)
                                    .cornerRadius(25)
                                    .disabled(eta == 4 ? false : true)
                            }
                        }
                        .frame(width: screenWidth)
                        .padding(.vertical)
                    }
                    if eta == -2 {
                        VStack(alignment: .center){
                            Text(finalInvoice)
                                .frame(width: screenWidth/1.4, height: screenHeight/16)
                                .background(Color.positive)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(25)
                            HStack{
                                ExDivider()
                            }
                            Text("ERROR")
                                .frame(width: screenWidth/1.4, height: screenHeight/16)
                                .background(Color.primary)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(25)
                            HStack{
                                ExDivider()
                            }
                            Text("Invoice could not be found")
                                .frame(width: screenWidth/1.4, height: screenHeight/16)
                                .background(Color.primary)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(25)
                        }
                        .padding(.vertical, 100.0)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search for your invoice ...", text: $text)
                        .onSubmit {
                            eta = getInvoiceStatus(invoice: text)
                            tracking = true
                        }
                }
                .padding(.all)
                .background(Color.light)
                .cornerRadius(40)
                .frame(width: screenWidth/1.1)
            }
            
            PopUpWindow(title: popUpTitle, message: popUpMessage, buttonText: "OK", show: $isPresented)
        }
    }
}

struct ExDivider: View {
    let color: Color = .gray
    let width: CGFloat = 1.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color.primary)
                    
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .medium))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.black)
                    
                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.primary)
                            .font(Font.system(size: 23, weight: .semibold))
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color.white)
            }
        }
    }
}
