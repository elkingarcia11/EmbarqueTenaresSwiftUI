import Firebase

public class HttpHeader : ObservableObject {
    @Published var apiKey : String = ""
    @Published var appId : String = ""
    @Published var url : String = ""
    @Published var httpHeaderChanged : Bool = false
    
    func getHttpHeaders() async throws{
        Firestore.firestore().collection("auth").document("login").addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                self.apiKey = ""
                self.appId = ""
                self.url = ""
                return
            }
            
            guard let data = document.data() else {
                self.apiKey = ""
                self.appId = ""
                self.url = ""
                return
            }
            self.apiKey = data["Api-Key"] as! String
            self.appId = data["App-Id"] as! String
            self.url = data["url"] as! String
        }
    }
    
    func firebaseToken() async throws -> String {
        guard let token = try await Auth.auth().currentUser?.getIDToken() else {
            throw FirebaseError.failToGetToken
        }
        return token
    }
}
