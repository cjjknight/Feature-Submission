import SwiftUI

struct ClosedFeatureRequestsView: View {
    @ObservedObject var viewModel = FeatureRequestViewModel()
    @State private var featureToEdit: FeatureRequest?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.featureRequests.filter { !$0.isOpen }) { request in
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
            .navigationBarTitle("Closed Feature Requests")
            .sheet(item: $featureToEdit) { feature in
                EditFeatureRequestView(viewModel: self.viewModel, projectViewModel: ProjectViewModel(), featureRequest: feature)
            }
            .onAppear {
                self.viewModel.fetchFeatureRequests()
            }
        }
    }
}

struct ClosedFeatureRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedFeatureRequestsView()
    }
}
