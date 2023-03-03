import Firebase
import SwiftUI

class FAQsViewModel: ObservableObject {
    @Published var faqs = [FAQs]()
    @Published var faqs_en: [QandA] = []
    @Published var faqs_es: [QandA] = []
    @Published var isLoading = false
    @Published var errorMsg : String = ""
    @Published var statusCode : Int = -2
    
    init(){
        self.fetchFAQs()
    }
    
    private func fetchFAQs(){
        self.isLoading = true
        // Get a reference to database
        let db = Firestore.firestore()
        
        // Read documents at specific path
        db.collection("faqs").getDocuments { snapshot, error in
            DispatchQueue.main.async {
                // Check for errors
                if error == nil {
                    if let snapshot = snapshot {
                        // Get all the documents and create FAQs
                        self.faqs = snapshot.documents.map{
                            d in
                            return FAQs(id: Int(d.documentID) ?? 0, q_en: d["q_en"] as? String ?? "", q_es: d["q_es"] as? String ?? "", a_en: d["a_en"] as? String ?? "", a_es: d["a_es"] as? String ?? "")
                        }
                        
                        self.setupQandA()
                    }
                    self.statusCode = 1
                } else {
                    self.statusCode = -1
                    self.errorMsg = "error_faqs"
                }
                self.isLoading = false
            }
        }
    }
    
    private func setupQandA(){
        for i in 0...faqs.count-1 {
            faqs_en.append(QandA(id: i, q: faqs[i].q_en, a: faqs[i].a_en))
            faqs_es.append(QandA(id: i, q: faqs[i].q_es, a: faqs[i].a_es))
        }
        faqs_en.append(QandA(id:10000000,q: "What app version is this?", a:"This is app version 2.0"))
        faqs_es.append(QandA(id:10000000,q: "¿Qué versión de la aplicación es esta?", a:"Esta es la versión de la aplicación 2.0"))
    }
}
