import SwiftUI

struct ProjectsView: View {
    @ObservedObject var viewModel = ProjectViewModel()
    @State private var showAddProject = false
    @State private var projectToEdit: Project?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.projects) { project in
                    Text(project.name)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                viewModel.deleteProject(project: project)
                            }
                            Button("Edit") {
                                projectToEdit = project
                            }
                            .tint(.blue)
                        }
                }
            }
            .navigationBarTitle("Projects")
            .navigationBarItems(trailing: Button(action: {
                self.showAddProject.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddProject) {
                AddProjectView(viewModel: self.viewModel)
            }
            .sheet(item: $projectToEdit) { project in
                EditProjectView(viewModel: self.viewModel, project: project)
            }
            .onAppear {
                self.viewModel.fetchProjects()
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
