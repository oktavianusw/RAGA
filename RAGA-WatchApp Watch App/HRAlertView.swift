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
                        HStack(alignment: .top) {
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
//                                            Spacer()
                                            Spacer(minLength: 10)
                                            if selectedZone == zone.0 {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.orange)
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                    }
                                    .frame(width: .infinity)
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
                                .clipShape(RoundedRectangle(cornerRadius: 1, style: .continuous))
                            }
                        }
                        .background(Color(red: 1.0, green: 0.98, blue: 0.86))
                        .cornerRadius(16)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
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
        HRAlertView()
    }
