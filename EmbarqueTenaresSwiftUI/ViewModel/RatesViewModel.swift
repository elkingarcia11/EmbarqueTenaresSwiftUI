import Combine
import Firebase


class RatesViewModel: ObservableObject {
    
    @Published var categories = [Category]()
    @Published var catsAndItems = [CategoryAndItems]()
    
    private var refHandle: DatabaseHandle?
    
    init(){
        Task {
            self.fetchCategories()
        }
        self.fetchItems()
    }
    private func fetchCategories() {
        // Get a reference to database
        let db = Firestore.firestore()
        
        // Read documents at specific path -- Get categories
        db.collection("rates").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Get all the documents and create [Items]
                    self.categories = snapshot.documents.map{
                        d in
                        return Category(id: Int(d.documentID) ?? 0, name_en: d["name_en"] as? String ?? "", name_es: d["name_es"] as? String ?? "")
                    }
                    self.fetchItems()
                }
            } else {
                //ERROR
            }
        }
    }
    
    private func fetchItems(){
        let db = Firestore.firestore()
        for category in self.categories {
            let docId = String(category.id)
            db.collection("rates").document(docId).collection("items").getDocuments{
                snapshot, error in
                // Check for errors
                if error == nil {
                    // No errors
                    var rateItems = [Item]()
                    if let snapshot = snapshot {
                        // Get all the documents and create [Items]
                        rateItems = snapshot.documents.map{
                            d in
                            return Item(id: Int(d.documentID) ?? 0, name_en: d["name_en"] as? String ?? "", name_es: d["name_es"] as? String ?? "", price:  d["price"] as? String ?? "")
                        }
                    }
                    self.catsAndItems.append(CategoryAndItems(id: category.id, category: category, items: rateItems))
                } else {
                    // ERROR
                }
            }
        }
    }
}
