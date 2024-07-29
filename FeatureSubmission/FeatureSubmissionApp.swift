import SwiftUI
import FirebaseCore

@main
struct FeatureSubmissionApp: App {
    // Register AppDelegate to handle Firebase configuration
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
