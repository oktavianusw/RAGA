import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let paceAlertBackground = Color(red: 1.0, green: 0.98, blue: 0.86) // #FFFADD
    static let alertText = Color(red: 0.29, green: 0.38, blue: 0.22)
}

// MARK: - Reusable Alert Button View
struct AlertButton: View {
    let title: String
    let subtitle: String
    let detail: String
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.alertText)
                Text(detail)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.alertText)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(width: 188, height: 63, alignment: .leading)
            .background(background)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 2)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(subtitle). \(detail).")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Main View
struct SetAlert: View {
    @State private var showHRAlert = false
    @State private var showPaceAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 24) {
                    // Title
                    HStack {
                        Spacer()
                        Text("Set alert")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

//                    Spacer(minLength: 24)

                    // Buttons
                    VStack(spacing: 16) {
                        AlertButton(
                            title: "HR Alert",
                            subtitle: "Zone 2",
                            detail: "Audio Guide On",
                            background: .paceAlertBackground,
                            action: { showHRAlert = true }
                        )

                        AlertButton(
                            title: "Pace Alert",
                            subtitle: "06'30'' - 07'00'' KM",
                            detail: "Audio Guide On",
                            background: .paceAlertBackground,
                            action: { showPaceAlert = true }
                        )
                    }

                    Spacer(minLength: 24)
                }
                .padding(.horizontal)
                .padding(.top, 35) // Title top padding for the whole VStack

                // Hidden NavigationLinks OUTSIDE main layout
                NavigationLink(destination: HRAlertView(), isActive: $showHRAlert) { EmptyView() }
                    .frame(width: 0, height: 0)
                NavigationLink(destination: PaceAlertView(), isActive: $showPaceAlert) { EmptyView() }
                    .frame(width: 0, height: 0)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SetAlert()
}
