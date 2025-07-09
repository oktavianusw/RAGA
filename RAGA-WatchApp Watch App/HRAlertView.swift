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
            ScrollView {
                VStack(spacing: 18) {
                    // Title
                    HStack {
                        Spacer()
                        Text("HR Alert")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                        
                    }
//                    .padding(.top, 16)

                    // Zones Card
                    VStack(spacing: 0) {
                        ForEach(paceZones, id: \.0) { zone in
                            Button(action: { selectedZone = zone.0 }) {
                                HStack {
                                    Text("Zone \(zone.0) |")
                                        .font(.system(size: 13, weight: .regular))
                                        .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                    Text(zone.1)
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                    Spacer()
                                    if selectedZone == zone.0 {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.orange)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.clear)
                            }
                            .buttonStyle(.plain)
                            if zone.0 != paceZones.last?.0 {
                                Divider()
                                    .background(Color(.black))
                                    .frame(maxWidth: .infinity)

                            }
                        }
                        // Off Option
                        Button(action: { selectedZone = nil }) {
                            HStack {
                                Text("Off")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                Spacer()
                                if selectedZone == nil {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                    .cornerRadius(16)
                    // No horizontal padding: edge-to-edge

                    // Guidance Card
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Guidance")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                        HStack {
                            Text("Audio Guide")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                            Spacer()
                            Toggle("", isOn: $audioGuideOn)
                                .labelsHidden()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                        .cornerRadius(16)
                    }
                    .frame(maxWidth: .infinity)
                    // No horizontal padding: edge-to-edge
                    .padding(.top, 8)

                    Spacer(minLength: 12)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    HRAlertView()
}
