import SwiftUI


struct HRAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedZone: Int? = 2
    @State private var audioGuideOn: Bool = true

    let paceZones = [
        (1, "<126 BPM"),
        (2, "126-140 BPM"),
        (3, "140-160 BPM"),
        (4, "160-180 BPM"),
        (5, ">180 BPM")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    // Title
                    HStack {
                        Spacer()
                        Text("HR Alert")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)

                    // Zone selection
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(paceZones, id: \.0) { zone in
                                Button(action: { selectedZone = zone.0 }) {
                                    HStack {
                                        Text("Zone \(zone.0) | ")
                                            .font(.system(size: 11, weight: .regular))
                                            .foregroundColor(.alertText)
                                        Text(zone.1)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.alertText)
                                        Spacer()
                                        if selectedZone == zone.0 {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.orange)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityLabel("Zone \(zone.0), \(zone.1)" + (selectedZone == zone.0 ? ", selected" : ""))
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color.clear)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.alertDivider),
                                    alignment: .bottom
                                )
                            }

                            Button(action: { selectedZone = nil }) {
                                HStack {
                                    Text("Off")
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(.alertText)
                                    Spacer()
                                    if selectedZone == nil {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.orange)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Off" + (selectedZone == nil ? ", selected" : ""))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .background(Color.paceAlertBackground)
                    .cornerRadius(16)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                    // Audio Guidance
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Guidance")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                        HStack {
                            Text("Audio Guide")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(.alertText)
                            Spacer()
                            Toggle("", isOn: $audioGuideOn)
                                .labelsHidden()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.paceAlertBackground)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 8)
                }
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    HRAlertView()
}
