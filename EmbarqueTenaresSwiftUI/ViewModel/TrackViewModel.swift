import Foundation

import Combine
import Firebase
import SwiftUI

@MainActor
final class TrackViewModel: ObservableObject {
    
    // Stores token
    @Published var authToken : Token?
    @Published var invoiceResponse : InvoiceResponse?
    @Published var state : APIState = .na
    @Published var errorMsg : String = ""
    
    
    @Published var invoice : String = ""
    @Published var progressValue: Float = 0
    @Published private var deliveryTime: Int = 0
    @Published var daysLeft: Int = 0
    @Published private var pickUpDate : String = ""
    @Published var arrivalDate_en : String = ""
    @Published var arrivalDate_es : String = ""
    
    
    let apiKey = "922eb8994ce5de69ef5347f0"
    let appId = "80cdea5d-f640-4128-b56b-44a377779fda"
    
    public func login() async throws {
        do {
            try await loadAndStoreToken()
        } catch {
            throw error
        }
    }
    
    private func loadAndStoreToken() async throws {
        guard let url = URL(string: "https://api.embarquero.com/api/tenares/auth/login")
        else {
            throw APIError.apiUrlNotSet
        }
        var urlRequest = URLRequest(url: url)
        
        // Create object to store log in response which will be ->
            // APIResponse is status, action, message, response object
            // LogInResponse is a response object with a token object and user object
            // Token object contains access and refresh fields
            // user object contains id fullname username active and role
        var result : APIResponse<LogInResponse>
        let objectType = APIResponse<LogInResponse>.self
        
        // Set up headers for login request
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(appId, forHTTPHeaderField: "App-Id")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        
        // Set up body for login request
        let body: [String: Any] = ["Username": "elkin", "Type":"MOBILE"]
        // Serialize body into json
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let statuscode = (response as? HTTPURLResponse)?.statusCode else { throw APIError.apiError("Failed to login")}
        if(200...299).contains(statuscode){
            result = try JSONDecoder().decode(objectType, from: data)
            let logInResponse = result.response[0]
            self.authToken = logInResponse.token
        } else {
            throw APIError.apiError("Failed to fetch token")
        }
    }
    
    public func getETA(invoiceNumber : String) async throws {
        self.state = .loading
        // Check if invoice is number && > 0
        if let i = Int(invoiceNumber) {
            if i > 0 {
                do {
                    try await fetchInvoice(invoiceNumber : invoiceNumber)
                } catch {
                    throw error
                }
            } else {
                self.state = .failed
                self.errorMsg = "error_eta3"
            }
        } else {
            self.state = .failed
            self.errorMsg = "error_eta3"
        }
    }
    
    private func fetchInvoice(invoiceNumber : String) async throws {
        guard let url = URL(string: "https://api.embarquero.com/api/tenares/invoice/\(invoiceNumber)") else {
            throw APIError.apiUrlNotSet
        }
        
        var urlRequest = URLRequest(url: url)
        
        var result : APIResponse<InvoiceResponse>
        let objectType = APIResponse<InvoiceResponse>.self
        
        // Set up headers for login request
        urlRequest.httpMethod = "GET"
        
        // Set up header for fetch invoice request
        urlRequest.setValue("Bearer \(self.authToken?.access ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(appId, forHTTPHeaderField: "App-Id")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let statuscode = (response as? HTTPURLResponse)?.statusCode else { throw APIError.apiError("Error while fetching invoice") }
        if(200...299).contains(statuscode){
            result = try JSONDecoder().decode(objectType, from: data)
            self.invoiceResponse = result.response[0]
            if let pickupDate = self.invoiceResponse?.date {
                self.pickUpDate = pickupDate
            }
            try await self.fetchDeliveryTime()
        } else {
            throw APIError.apiError("Error while fetching invoice")
        }
    }
    
    private func fetchDeliveryTime() async throws {
        let db = Firestore.firestore()
        let docRef = db.collection("eta").document("eta_days")
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                self.state = .failed
                self.errorMsg = "error_eta1"
                print("1")
                return
            }
            if let document = document, document.exists {
                self.deliveryTime = document.get("days") as? Int ?? -1
                if self.deliveryTime == -1 {
                    self.state = .failed
                    self.errorMsg = "error_eta1"
                    print("2")
                } else {
                    self.calculateETA()
                }
            }
        }
    }
    
    func resetVars() async {
        self.state = .na
        self.progressValue = 0
        self.deliveryTime = 0
        self.daysLeft = 0
        self.errorMsg = ""
        self.pickUpDate = ""
        self.arrivalDate_es = ""
        self.arrivalDate_es = ""
    }
    
    func calculateETA(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let range = self.pickUpDate.index(self.pickUpDate.startIndex, offsetBy: 10)..<self.pickUpDate.endIndex
        self.pickUpDate.removeSubrange(range)
        print("pick up date", self.pickUpDate)
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
                print("3")
            }
        } else {
            self.state = .failed
            self.errorMsg = "error_eta1"
            print("4")
        }
    }
}
