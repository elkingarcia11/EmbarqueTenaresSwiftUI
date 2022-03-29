import Foundation

import Combine
import Firebase

class TrackViewModel: ObservableObject {
    
    @Published var searchStatus = -2
    
    @Published var progressValue: Float = 0
    
    @Published private var deliveryTime: Int = 0
    
    @Published var daysLeft: Int = 0
    
    
    
    @Published private var originalDate : String = ""
    @Published var arrivalDate : String = ""
    
    @Published private var error_1 : String = ""
    @Published private var error_2 : String = ""
    
    @Published var isLoading = false
    
    private func fetchEtaDay(){
        self.isLoading = true
        let db = Firestore.firestore()
        let docRef = db.collection("eta").document("eta_days")
        
        docRef.getDocument { (document, error) in
            DispatchQueue.main.async{
                if let document = document, document.exists {
                    self.deliveryTime = document.get("days") as? Int ?? -1
                }
                if self.deliveryTime == -1 {
                    
                    self.error_1 = "Failed to calculate estimated time of arrival"
                    self.error_2 = ""
                    self.searchStatus = -1
                } else {
                    self.calculateETA()
                }
                self.isLoading = false
            }
        }
    }
    
    func calculateETA(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        // TURN original date string INTO DATE OBJECT
        if let ogDate = dateFormatter.date(from: self.originalDate){// CALCULATE ARRIVAL DATE
            
            print("DELIVERY TIME:\(self.deliveryTime)")
            if let arrDate = Calendar.current.date(byAdding: .day, value: self.deliveryTime, to: ogDate) {
                // TURN ARRIVAL DATE INTO STRING TO PRESENT IN VIEW
                let stringFormatter = DateFormatter()
                stringFormatter.dateStyle = .long
                stringFormatter.timeStyle = .none
                arrivalDate = stringFormatter.string(from: arrDate)
                daysLeft = Int(Date().distance(to: arrDate))/60/60/24+1
                
                if daysLeft <= 0 {
                    progressValue = 1
                } else {
                    progressValue = Float(1-(Float(daysLeft)/Float(deliveryTime)))
                }
                self.searchStatus = 1
            } else {
                error_1 = "Failed to calculate estimated time of arrival"
                error_2 = ""
                self.searchStatus = -1
            }
        }
        else {
            error_1 = "Failed to calculate estimated time of arrival"
            error_2 = ""
            self.searchStatus = -1
        }
    }
    
    func getETA(invoice : String){
        // Check if invoice is number && > 0
        if let i = Int(invoice) {
            if i > 0 {
                // If successfully connected to hector's db and retrieved invoice
                if self.fetchInvoiceDate(invoice: invoice) {
                    // If succesfully connected to my db and retrieve eta day
                    self.fetchEtaDay()
                } else {
                    // throw error
                    error_1 = "Failed to retrieve invoice information"
                    error_2 = ""
                    self.searchStatus = -1
                }
            } else {
                // throw error
                error_1 = "Invoice is invalid. Please enter a valid invoice number."
                error_2 = ""
                self.searchStatus = -1
            }
            
        } else {
            // throw error
            error_1 = "Invoice is invalid. Please enter a valid invoice number."
            error_2 = ""
            self.searchStatus = -1
        }
        
    }
    
    private func fetchInvoiceDate(invoice : String) -> Bool {
        /* CONNECT TO HECTORS DB
         fetch invoice date
         IF SUCCESS && INVOICE EXIST,
         //
         // ogDate = invoice.date
         // get delivery time
         // IF SUCCESS && DELIVERY TIME EXISTS
         // ELSE THROW ERROR
         // ELSE THROW ERROR
         */
        
        // GET DATE OF INVOICE FROM DB
        self.originalDate = "2022-03-14"
        return true
        // return false if error
    }
}
