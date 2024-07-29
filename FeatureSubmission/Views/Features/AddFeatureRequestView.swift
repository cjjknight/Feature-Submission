import SwiftUI

struct AddFeatureRequestView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FeatureRequestViewModel
    @ObservedObject var projectViewModel: ProjectViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var selectedProject = ""
    @State private var type = "Feature"
    @State private var priority = "Medium"
    @State private var isOpen = true
    @State private var showAddProject = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                Section(header: Text("Description")) {
                    TextField("Enter description", text: $description)
                }
                Section(header: Text("Project Name")) {
                    Picker("Select Project", selection: $selectedProject) {
                        ForEach(projectViewModel.projects, id: \.id) { project in
                            Text(project.name).tag(project.name)
                        }
                        Text("Add New Project").tag("addNew")
                    }
                    .onChange(of: selectedProject) { newValue in
                        if newValue == "addNew" {
                            showAddProject = true
                        }
                    }
                }
                Section(header: Text("Type")) {
                    Picker("Select Type", selection: $type) {
                        Text("Feature").tag("Feature")
                        Text("Bug").tag("Bug")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Priority")) {
                    Picker("Select Priority", selection: $priority) {
                        ForEach(["Low", "Medium", "High"], id: \.self) { priority in
                            Text(priority)
                        }
                    }
                }
                Section(header: Text("Status")) {
                    Toggle(isOn: $isOpen) {
                        Text("Open")
                    }
                }
                Button(action: {
                    let newFeatureRequest = FeatureRequest(
                        title: self.title,
                        description: self.description,
                        type: self.type,
                        priority: self.priority,
                        projectName: self.selectedProject,
                        isOpen: self.isOpen,
                        timestamp: Date()
                    )
                    self.viewModel.addFeatureRequest(featureRequest: newFeatureRequest)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit")
                }
            }
            .navigationBarTitle("Add Feature Request")
            .sheet(isPresented: $showAddProject) {
                AddProjectView(viewModel: self.projectViewModel)
            }
        }
    }
}

struct AddFeatureRequestView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeatureRequestView(viewModel: FeatureRequestViewModel(), projectViewModel: ProjectViewModel())
    }
}
