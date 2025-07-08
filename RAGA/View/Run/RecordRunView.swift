import SwiftUI

struct RecordRunView: View {
    @Binding var isPresented: Bool
    
    @EnvironmentObject var userSettings: UserSettings
    @StateObject private var viewModel: SettingsViewModel
    
    // Updated initializer to be cleaner since we pass the binding now
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        _viewModel = StateObject(wrappedValue: SettingsViewModel(settings: UserSettings()))
    }

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()
            
            VStack {
                headerView
                
                ScrollView {
                    VStack(spacing: 16) {

                        settingsForm
                    }
                }
                
                Spacer()
                
                startButton
            }
            .padding(.top)
        }
        .onAppear {
            // Correctly inject the environment object into the view model
            viewModel.settings = userSettings
        }
        .navigationBarHidden(true)
    }

    private var headerView: some View {
        HStack {
            Button(action: { isPresented = false }) { // This now dismisses the sheet
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Record Run")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "person.circle.fill")
                .font(.title2)
                .foregroundColor(.white)
                .opacity(0) // Hidden but maintains spacing
        }
        .padding(.horizontal)
    }

    private var settingsForm: some View {
        VStack(spacing: 12) {
            // Heart Rate Section
            VStack(alignment: .leading, spacing: 1) {
                Text("HEART RATE")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading)
                
                Toggle("Heart Rate Alert", isOn: $viewModel.settings.heartRateAlertOn)
                    .padding()
                    .background(Color.appCream)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                NavigationLink(destination: HRZonesView(zones: $viewModel.settings.heartRateZones)) {
                     SettingsRow(title: "Alert on", value: viewModel.enabledZonesSummary)
                }
                 .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            
            // Pace Section
            VStack(alignment: .leading, spacing: 1) {
                Text("PACE")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading)
                
                Toggle("Pace Alert", isOn: $viewModel.settings.paceAlertOn)
                    .padding()
                    .background(Color.appCream)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                NavigationLink(destination: PaceLimitPickerView(title: "Upper Limit", pace: $viewModel.settings.upperPaceLimit)) {
                     SettingsRow(title: "Upper Limit", value: viewModel.settings.upperPaceLimit.displayString + " /KM")
                }
                
                NavigationLink(destination: PaceLimitPickerView(title: "Lower Limit", pace: $viewModel.settings.lowerPaceLimit)) {
                     SettingsRow(title: "Lower Limit", value: viewModel.settings.lowerPaceLimit.displayString + " /KM")
                }
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
        }
        .padding(.horizontal)
    }

    private var startButton: some View {
        // We now pass the presentation binding down to the RunView
        NavigationLink(destination: RunView(viewModel: RunViewModel(settings: userSettings), isPresented: $isPresented)) {
            Text("Start Run")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.appGreen)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.appCream)
                .cornerRadius(15)
        }
        .padding()
    }
}

// Helper to round specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Wrapper for previewing a view that needs a binding
fileprivate struct RecordRunView_PreviewWrapper: View {
    @State private var isPresented = true
    
    var body: some View {
        RecordRunView(isPresented: $isPresented)
            .environmentObject(UserSettings())
    }
}

#Preview {
    NavigationStack {
        RecordRunView_PreviewWrapper()
    }
}
