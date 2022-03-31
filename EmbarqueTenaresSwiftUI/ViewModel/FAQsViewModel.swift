import Combine
import Firebase
import SwiftUI

class FAQsViewModel: ObservableObject {
    
    @Published var faqs = [FAQs]()
    
    @Published var faqs_en: [QandA] = []
    
    @Published var faqs_es: [QandA] = []
    
    @Published var faqs_published: [QandA] = []
    
    @Published var isLoading = false
    
    @Published var errorMsg : LocalizedStringKey = ""
    
    init(){
        self.fetchFAQs()
    }
    
    private func fetchFAQs(){
        isLoading = true
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
                } else {
                    self.errorMsg = "error_rates"
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
    }
}
