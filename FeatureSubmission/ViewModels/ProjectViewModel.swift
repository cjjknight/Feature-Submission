import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectViewModel: ObservableObject {
    @Published var projects = [Project]()
    
    private var db = Firestore.firestore()
    
    func fetchProjects() {
        db.collection("projects").order(by: "name").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            self.projects = querySnapshot?.documents.compactMap { document -> Project? in
                try? document.data(as: Project.self)
            } ?? []
        }
    }
    
    func addProject(project: Project) {
        do {
            _ = try db.collection("projects").addDocument(from: project)
        } catch let error {
            print("Error writing document: \(error)")
        }
    }
    
    func deleteProject(project: Project) {
        if let id = project.id {
            db.collection("projects").document(id).delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                }
            }
        }
    }
}
