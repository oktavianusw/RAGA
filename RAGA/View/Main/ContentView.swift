import SwiftUI

struct ContentView: View {
    // This is the single source of truth for all user settings
    @StateObject private var userSettings = UserSettings()
    
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationBarHidden(true)
        }
        // EnvironmentObject makes settings available to any view in the hierarchy
        .environmentObject(userSettings)
    }
}

#Preview {
    ContentView()
}
