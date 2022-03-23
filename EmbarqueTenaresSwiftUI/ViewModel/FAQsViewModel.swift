//
//  FAQsViewModel.swift
//  Tenares Shipping
//
//  Created by Elkin Garcia on 3/21/22.
//

import Combine
import Firebase

class FAQsViewModel: ObservableObject {
    
    @Published var faqs = [FAQs]()
    
    @Published var faqs_en: [QandA] = []
    
    @Published var faqs_es: [QandA] = []
    
    @Published var faqs_published: [QandA] = []
    
    private var refHandle: DatabaseHandle?
    
    init(){
        self.fetchFAQs()
        //self.fetchFAQSTest()
        // TURN JSON INTO LIST OF FAQS OBJECTS
        
        // For each item in FAQs fetched from db, make two QandA arrays for each language
        /*            for i in 0 ... faqs.count - 1 {
         let q_en = QandA(faqs[i].q_en, faqs[i].a_en)
         let q_es = QandA(faqs[i].q_es, faqs[i].a_es)
         questions_en.append(q_en)
         questions_es.append(q_es)
         }*/
    }
    
    private func fetchFAQSTest(){
        let o = FAQs(id: 0, q_en: "YOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOO", q_es: "YOO", a_en: "YOO", a_es: "YOO")
        let i = FAQs(id: 1, q_en: "YOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOO", q_es: "YOO", a_en: "YOO", a_es: "YOO")
        let a = FAQs(id: 2, q_en: "YOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOO", q_es: "YOO", a_en: "YOO", a_es: "YOO")
        let e = FAQs(id: 3, q_en: "YOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOO", q_es: "YOO", a_en: "YOO", a_es: "YOO")
        let u = FAQs(id: 4, q_en: "YOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOOYOO", q_es: "YOO", a_en: "YOO", a_es: "YOO")
        faqs = [o,i,a,e,u]
        
    }
    
    private func fetchFAQs(){
        // Get a reference to database
        let db = Firestore.firestore()
        
        // Read documents at specific path
        db.collection("faqs").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                print("NO ERRORS RETRIEVING DB")
                if let snapshot = snapshot {
                    // Get all the documents and create FAQs
                    self.faqs = snapshot.documents.map{
                        d in
                        return FAQs(id: Int(d.documentID) as? Int ?? 0, q_en: d["q_en"] as? String ?? "", q_es: d["q_es"] as? String ?? "", a_en: d["a_en"] as? String ?? "", a_es: d["a_es"] as? String ?? "")
                    }
                    
                    self.setupQandA()
                }
            } else {
                print("ERROR RETRIEVING DB")
            }
        }
    }
    
    private func setupQandA(){
        for i in 0...faqs.count-1 {
            faqs_en.append(QandA(id: i, q: faqs[i].q_en, a: faqs[i].a_en))
            faqs_en.append(QandA(id: i, q: faqs[i].q_es, a: faqs[i].a_es))
        }
        
        updateFAQsLanguage()
    }
    
    private func updateFAQsLanguage(){
        let langStr = Locale.current.languageCode
        
        if langStr == "es"{
            faqs_published = faqs_es
        } else {
            faqs_published = faqs_en
        }
    }
}
