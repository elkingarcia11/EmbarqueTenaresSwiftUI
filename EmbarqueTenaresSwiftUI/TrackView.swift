//
//  TrackView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI


struct TrackView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
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
        
        return Int(newInv)!
        //return -2
    }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack{
                Text("Track Invoice")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(eta > -1 ? 10.0 : 0)
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
                                //self.showPopUp(0)
                            })
                                .foregroundColor(.white)
                                .padding()
                                .font(.subheadline)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(Color.primary)
                                .cornerRadius(25)
                            HStack{
                                ExDivider()
                            }
                            Button("En transito", action: {
                                //self.showPopUp(1)
                            })
                                .foregroundColor(.white)
                                .padding()
                                .font(.subheadline)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(eta > 0 ? Color.primary : Color.gray)
                                .cornerRadius(25)
                            
                            HStack{
                                ExDivider()
                            }
                            Button("Almacen RD", action: {
                                //self.showPopUp(2)
                            })
                                .foregroundColor(.white)
                                .padding()
                                .font(.subheadline)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(eta > 1 ? Color.primary : Color.gray)
                                .cornerRadius(25)
                            
                            HStack{
                                ExDivider()
                            }
                            Button("En camino", action: {
                                //self.showPopUp(3)
                            })
                                .foregroundColor(.white)
                                .padding()
                                .font(.subheadline)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(eta > 2 ? Color.primary : Color.gray)
                                .cornerRadius(25)
                            HStack{
                                ExDivider()
                            }
                            
                            Button("Entregado", action: {
                                //self.showPopUp(4)
                            })
                                .foregroundColor(.white)
                                .padding()
                                .font(.subheadline)
                                .frame(width: screenWidth/2, height: screenHeight/16)
                                .background(eta > 3 ? Color.primary : Color.gray)
                                .cornerRadius(25)
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
                TextField("Search for invoice", text: $text)
                    .onSubmit {
                        eta = getInvoiceStatus(invoice: text)
                    }
            }
            .padding()
            .background(Color.light)
            .cornerRadius(40)
            .frame(width: screenWidth/1.1)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(.custom("American Typewriter", size: 24))
            .background(Color.red)
            .border(Color.purple)
            .cornerRadius(8)
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
