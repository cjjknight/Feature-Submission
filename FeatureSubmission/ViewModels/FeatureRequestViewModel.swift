import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FeatureRequestViewModel: ObservableObject {
    @Published var featureRequests = [FeatureRequest]()
    
    private var db = Firestore.firestore()
    
    func fetchFeatureRequests() {
        db.collection("featureRequests").order(by: "timestamp", descending: true).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.featureRequests = querySnapshot?.documents.compactMap { document -> FeatureRequest? in
                try? document.data(as: FeatureRequest.self)
            } ?? []
        }
    }
    
    func addFeatureRequest(featureRequest: FeatureRequest) {
        do {
            _ = try db.collection("featureRequests").addDocument(from: featureRequest)
        } catch let error {
            print("Error writing document: \(error)")
        }
    }
    
    func deleteFeatureRequest(featureRequest: FeatureRequest) {
        if let id = featureRequest.id {
            db.collection("featureRequests").document(id).delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                }
            }
        }
    }
    
    func updateFeatureRequest(featureRequest: FeatureRequest) {
        if let id = featureRequest.id {
            do {
                try db.collection("featureRequests").document(id).setData(from: featureRequest)
            } catch let error {
                print("Error updating document: \(error)")
            }
        }
    }
}
