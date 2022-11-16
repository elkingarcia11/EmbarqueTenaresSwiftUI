import Foundation
import Firebase
import SwiftUI

@MainActor
final class TrackViewModel: ObservableObject {
    
    @Published var state : APIState = .na
    @Published var errorMsg : String = ""
    @Published var progressValue: Float = 0
    @Published private var deliveryTime: Int = 0
    @Published var daysLeft: Int = 0
    @Published private var pickUpDate : String = ""
    @Published var arrivalDate_en : String = ""
    @Published var arrivalDate_es : String = ""
    
    func resetVars() {
        self.state = .na
        self.progressValue = 0
        self.deliveryTime = 0
        self.daysLeft = 0
        self.errorMsg = ""
        self.pickUpDate = ""
        self.arrivalDate_es = ""
        self.arrivalDate_es = ""
    }
    
    public func isValidInvoice(invoiceNumber : String) -> Bool {
        self.state = .loading
        // Check if invoice is number && > 0
        if let i = Int(invoiceNumber) {
            if i < 0 {
                self.state = .failed
                self.errorMsg = "error_eta3"
                return false
            } else {
                return true
            }
        } else {
            self.state = .failed
            self.errorMsg = "error_eta3"
            return false
        }
    }
    
    func fetchInvoice(invoiceNumber : String, appId : String?, apiKey : String?, token : String?) async throws {
        guard let url = URL(string: "https://api.embarquero.com/api/tenares/invoice/\(invoiceNumber)") else {
            self.state = .failed
            self.errorMsg = "error_api"
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        var result : APIResponse<InvoiceResponse>
        let objectType = APIResponse<InvoiceResponse>.self
        
        // Set up headers for login request
        urlRequest.httpMethod = "GET"
        
        // Set up header for fetch invoice request
        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(appId, forHTTPHeaderField: "App-Id")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let statuscode = (response as? HTTPURLResponse)?.statusCode else {
            self.state = .failed
            self.errorMsg = "error_res"
            return
        }
        
        if(200...299).contains(statuscode){
            result = try JSONDecoder().decode(objectType, from: data)
            let invoiceResponse = result.response[0]
            self.pickUpDate = invoiceResponse.date
            await self.fetchDeliveryTime()
        } else {
            self.state = .failed
            self.errorMsg = "error_inv"
        }
    }
    
    private func fetchDeliveryTime() async {
        let db = Firestore.firestore()
        let docRef = db.collection("eta").document("eta_days")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.deliveryTime = document.get("days") as? Int ?? -1
                if self.deliveryTime == -1 {
                    self.state = .failed
                    self.errorMsg = "error_eta1"
                } else {
                    self.calculateETA()
                }
            } else {
                self.state = .failed
                self.errorMsg = "error_eta1"
            }
        }
    }

    func calculateETA(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let range = self.pickUpDate.index(self.pickUpDate.startIndex, offsetBy: 10)..<self.pickUpDate.endIndex
        self.pickUpDate.removeSubrange(range)
        // TURN original date string INTO DATE OBJECT
        if let pickupDate = dateFormatter.date(from: self.pickUpDate){
            // CALCULATE ARRIVAL DATE
            if let arrDate = Calendar.current.date(byAdding: .day, value: self.deliveryTime, to: pickupDate) {
                // TURN ARRIVAL DATE INTO STRING TO PRESENT IN VIEW
                let stringFormatter = DateFormatter()
                stringFormatter.dateStyle = .long
                stringFormatter.timeStyle = .none
                stringFormatter.locale = Locale(identifier: "es_US")
                self.arrivalDate_es = stringFormatter.string(from: arrDate)
                stringFormatter.locale = Locale(identifier: "en_US")
                self.arrivalDate_en = stringFormatter.string(from: arrDate)
                self.daysLeft = Int(Date().distance(to: arrDate))/60/60/24+1
                
                if self.daysLeft <= 0 {
                    self.daysLeft = 0
                }
                self.progressValue = Float(1-(Float(daysLeft)/Float(deliveryTime)))
                self.state = .successful
            } else {
                self.state = .failed
                self.errorMsg = "error_eta1"
            }
        } else {
            self.state = .failed
            self.errorMsg = "error_eta1"
        }
    }
}
