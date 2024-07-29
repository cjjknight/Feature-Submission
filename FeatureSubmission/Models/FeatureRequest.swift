import Foundation
import FirebaseFirestoreSwift

struct FeatureRequest: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var type: String // "Bug" or "Feature"
    var priority: String // "Low", "Medium", or "High"
    var projectName: String
    var isOpen: Bool
    var timestamp: Date
}
