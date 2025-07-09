import SwiftUI

struct PaceAlertView: View {
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
                    HStack(alignment: .top) {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Circle()
                                .fill(Color(.black))
                                .frame(width: 30, height: 30)  // Reduced the size of the back button
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .regular, design: .rounded))  // Reduced font size for chevron
                                        .foregroundColor(.secondary)
                                )
                        }
                        Spacer()
                        Text("HR Alert")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    
                    VStack(spacing: 0) {
                        VStack(alignment : .leading,spacing: 0) {
                            ForEach(paceZones, id: \.0) { zone in
                                Button(action: { selectedZone = zone.0 }) {
                                    HStack {
                                        Text("Zone \(zone.0) | ")
                                            .font(.system(size: 11, weight: .regular))
                                            .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                        Text(zone.1)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                        Spacer()
                                        if selectedZone == zone.0 {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.orange)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                }
                                .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.7)),
                                    alignment: .bottom
                                )
                            }
                            
                            Button(action: { selectedZone = nil }) {
                                HStack {
                                    Text("Off")
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(Color(red: 0.29, green: 0.38, blue: 0.22))
                                    Spacer()
                                    if selectedZone == nil {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.orange)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                            }
                            .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                        .cornerRadius(16)
                    }
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 8) {
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
                        .padding(.horizontal, 16)
                        .background(Color(red: 1.0, green: 0.98, blue: 0.86))
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
    PaceAlertView()
}
