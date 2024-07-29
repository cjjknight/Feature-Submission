import Foundation
import FirebaseFirestoreSwift

struct Project: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
}
