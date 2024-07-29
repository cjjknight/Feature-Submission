import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            OpenFeatureRequestsView()
                .tabItem {
                    Image(systemName: "tray.full")
                    Text("Open")
                }
            
            ClosedFeatureRequestsView()
                .tabItem {
                    Image(systemName: "tray")
                    Text("Closed")
                }
            
            ProjectsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Projects")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
