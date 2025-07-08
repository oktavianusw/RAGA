import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        ZStack {
            Color.appCream.ignoresSafeArea()
            
            VStack {
                headerView
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        personalDetailsSection
                        heartRateSection
                        paceSection
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }

    private var headerView: some View {
        HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Profile")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            // Placeholder for right side alignment
            Image(systemName: "chevron.left").opacity(0)
        }
        .padding()
        .background(Color.appCream)
    }

    private var personalDetailsSection: some View {
        VStack(alignment: .leading) {
            Text("PERSONAL DETAILS")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            VStack(spacing: 1) {
                // For a real app, these would lead to editing views
                SettingsRow(title: "Name", value: settings.name)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                SettingsRow(title: "Age", value: "\(settings.age) years")
                NavigationLink(destination: GenderSelectionView(selectedGender: $settings.gender)) {
                    SettingsRow(title: "Gender", value: settings.gender)
                }
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
        }
    }

    private var heartRateSection: some View {
        VStack(alignment: .leading) {
            Text("HEART RATE")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            VStack(spacing: 1) {
                Toggle("Heart Rate Alert", isOn: $settings.heartRateAlertOn)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                Toggle("Audio Guidance", isOn: $settings.audioGuidanceOn)
                    .padding()
                    .background(Color.white)

                // The design shows Zone 1 as an example
                let enabledZones = settings.heartRateZones.filter { $0.isEnabled }
                let zoneValue = enabledZones.isEmpty ? "None" : enabledZones.first!.name
                
                NavigationLink(destination: HRZonesView(zones: $settings.heartRateZones, isCustomizing: true)) {
                    SettingsRow(title: "Alerted Zones", value: zoneValue)
                }
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
        }
    }
    
    private var paceSection: some View {
        VStack(alignment: .leading) {
            Text("PACE")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            VStack(spacing: 1) {
                Toggle("Audio Guidance", isOn: $settings.paceAlertOn)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                NavigationLink(destination: PaceLimitPickerView(title: "Lower Limit", pace: $settings.lowerPaceLimit)) {
                     SettingsRow(title: "Lower Limit", value: settings.lowerPaceLimit.displayString + " /KM")
                }
                
                NavigationLink(destination: PaceLimitPickerView(title: "Upper Limit", pace: $settings.upperPaceLimit)) {
                     SettingsRow(title: "Upper Limit", value: settings.upperPaceLimit.displayString + " /KM")
                }
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(UserSettings())
    }
}
