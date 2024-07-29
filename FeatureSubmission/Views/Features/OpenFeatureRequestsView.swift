import SwiftUI

struct OpenFeatureRequestsView: View {
    @ObservedObject var viewModel = FeatureRequestViewModel()
    @ObservedObject var projectViewModel = ProjectViewModel()
    @State private var showAddFeatureRequest = false
    @State private var featureToEdit: FeatureRequest?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.featureRequests.filter { $0.isOpen }) { request in
                    VStack(alignment: .leading) {
                        Text(request.title).font(.headline)
                        Text(request.description).font(.subheadline)
                        Text("Type: \(request.type)").font(.caption)
                        Text("Priority: \(request.priority)").font(.caption)
                        Text("Project: \(request.projectName)").font(.caption)
                        Text("\(request.timestamp, formatter: DateFormatter())").font(.caption)
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            viewModel.deleteFeatureRequest(featureRequest: request)
                        }
                        Button("Edit") {
                            featureToEdit = request
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationBarTitle("Open Feature Requests")
            .navigationBarItems(trailing: Button(action: {
                self.showAddFeatureRequest.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddFeatureRequest) {
                AddFeatureRequestView(viewModel: self.viewModel, projectViewModel: self.projectViewModel)
            }
            .sheet(item: $featureToEdit) { feature in
                EditFeatureRequestView(viewModel: self.viewModel, projectViewModel: self.projectViewModel, featureRequest: feature)
            }
            .onAppear {
                self.viewModel.fetchFeatureRequests()
                self.projectViewModel.fetchProjects()
            }
        }
    }
}

struct OpenFeatureRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        OpenFeatureRequestsView()
    }
}
