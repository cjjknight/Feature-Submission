import SwiftUI

struct EditFeatureRequestView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FeatureRequestViewModel
    @ObservedObject var projectViewModel: ProjectViewModel
    
    @State private var title: String
    @State private var description: String
    @State private var selectedProject: String
    @State private var type: String
    @State private var priority: String
    @State private var isOpen: Bool
    @State private var showAddProject = false
    
    var featureRequest: FeatureRequest
    
    init(viewModel: FeatureRequestViewModel, projectViewModel: ProjectViewModel, featureRequest: FeatureRequest) {
        self.viewModel = viewModel
        self.projectViewModel = projectViewModel
        self.featureRequest = featureRequest
        _title = State(initialValue: featureRequest.title)
        _description = State(initialValue: featureRequest.description)
        _selectedProject = State(initialValue: featureRequest.projectName)
        _type = State(initialValue: featureRequest.type)
        _priority = State(initialValue: featureRequest.priority)
        _isOpen = State(initialValue: featureRequest.isOpen)
    }
    
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
                    var updatedFeatureRequest = featureRequest
                    updatedFeatureRequest.title = title
                    updatedFeatureRequest.description = description
                    updatedFeatureRequest.projectName = selectedProject
                    updatedFeatureRequest.type = type
                    updatedFeatureRequest.priority = priority
                    updatedFeatureRequest.isOpen = isOpen
                    viewModel.updateFeatureRequest(featureRequest: updatedFeatureRequest)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Edit Feature Request")
            .sheet(isPresented: $showAddProject) {
                AddProjectView(viewModel: self.projectViewModel)
            }
        }
    }
}

struct EditFeatureRequestView_Previews: PreviewProvider {
    static var previews: some View {
        EditFeatureRequestView(viewModel: FeatureRequestViewModel(), projectViewModel: ProjectViewModel(), featureRequest: FeatureRequest(
            id: "1",
            title: "Sample",
            description: "Sample Description",
            type: "Feature",
            priority: "High",
            projectName: "Project1",
            isOpen: true,
            timestamp: Date()
        ))
    }
}
