import SwiftUI

struct AddProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProjectViewModel
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Button(action: {
                    let newProject = Project(name: self.name)
                    self.viewModel.addProject(project: newProject)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit")
                }
            }
            .navigationBarTitle("Add Project")
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(viewModel: ProjectViewModel())
    }
}
