import Foundation
import Firebase

class HttpHeader : ObservableObject {
    @Published var apiKey : String = ""
    @Published var appId : String = ""
    @Published var httpHeaderChanged : Bool = false
    
    func getHttpHeaders() async throws{
        Firestore.firestore().collection("auth").document("login").addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                self.apiKey = ""
                self.appId = ""
                return
            }
            
            guard let data = document.data() else {
                self.apiKey = ""
                self.appId = ""
                return
            }
            self.apiKey = data["Api-Key"] as! String
            self.appId = data["App-Id"] as! String
        }
    }

    static func firebaseToken() async throws -> String {
            guard let token = try await Auth.auth().currentUser?.getIDToken() else {
                throw FirebaseError.failToGetToken
            }
            return token
        }
}
