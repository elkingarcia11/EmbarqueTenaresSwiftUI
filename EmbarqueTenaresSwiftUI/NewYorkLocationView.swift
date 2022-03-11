//
//  RatesView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI
import MapKit

struct NewYorkLocationView: View {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.854525, longitude: -73.894139), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all)
                .frame(width: screenWidth-40, height: screenHeight/4)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            Spacer()
        }
    }
}
