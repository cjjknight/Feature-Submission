import SwiftUI

struct EditProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProjectViewModel
    @State private var name: String
    
    var project: Project
    
    init(viewModel: ProjectViewModel, project: Project) {
        self.viewModel = viewModel
        self.project = project
        _name = State(initialValue: project.name)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Button(action: {
                    var updatedProject = project
                    updatedProject.name = name
                    viewModel.addProject(project: updatedProject)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Edit Project")
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(viewModel: ProjectViewModel(), project: Project(id: "1", name: "Sample Project"))
    }
}
