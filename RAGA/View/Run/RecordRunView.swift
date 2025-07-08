import SwiftUI

struct RecordRunView: View {
    @Binding var isPresented: Bool
    let onStartRun: (RunViewModel) -> Void
    
    @EnvironmentObject var userSettings: UserSettings
    @StateObject private var viewModel: SettingsViewModel
    
    // Updated initializer to be cleaner since we pass the binding now
    init(isPresented: Binding<Bool>, onStartRun: @escaping (RunViewModel) -> Void) {
        self._isPresented = isPresented
        self.onStartRun = onStartRun
        _viewModel = StateObject(wrappedValue: SettingsViewModel(settings: UserSettings()))
    }

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()
            
            VStack(spacing: 12) {
                headerView
                
                VStack(spacing: 10) {
                    settingsForm
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
                    .font(.title3)
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Record Run")
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "person.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
                .opacity(0) // Hidden but maintains spacing
        }
        .padding(.horizontal)
    }

    private var settingsForm: some View {
        VStack(spacing: 8) {
            // Heart Rate Section
            VStack(alignment: .leading, spacing: 1) {
                Text("HEART RATE")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 8)
                
                Toggle("Heart Rate Alert", isOn: $viewModel.settings.heartRateAlertOn)
                    .padding(8)
                    .background(Color.appCream)
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                
                NavigationLink(destination: HRZonesView(zones: $viewModel.settings.heartRateZones)) {
                     SettingsRow(title: "Alert on", value: viewModel.enabledZonesSummary)
                }
                 .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
            }
            
            // Pace Section
            VStack(alignment: .leading, spacing: 1) {
                Text("PACE")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 8)
                
                Toggle("Pace Alert", isOn: $viewModel.settings.paceAlertOn)
                    .padding(8)
                    .background(Color.appCream)
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                
                NavigationLink(destination: PaceLimitPickerView(title: "Upper Limit", pace: $viewModel.settings.upperPaceLimit)) {
                     SettingsRow(title: "Upper Limit", value: viewModel.settings.upperPaceLimit.displayString + " /KM")
                }
                
                NavigationLink(destination: PaceLimitPickerView(title: "Lower Limit", pace: $viewModel.settings.lowerPaceLimit)) {
                     SettingsRow(title: "Lower Limit", value: viewModel.settings.lowerPaceLimit.displayString + " /KM")
                }
                .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
            }
        }
        .padding(.horizontal)
    }

    private var startButton: some View {
        Button(action: {
            let runViewModel = RunViewModel(settings: userSettings)
            onStartRun(runViewModel)
        }) {
            Text("Start Run")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.appGreen)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color.appCream)
                .cornerRadius(12)
        }
        .padding(12)
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
        RecordRunView(isPresented: $isPresented, onStartRun: { _ in })
            .environmentObject(UserSettings())
    }
}

#Preview {
    NavigationStack {
        RecordRunView_PreviewWrapper()
    }
}
