import SwiftUI

struct HRZonesView: View {
    @Binding var zones: [HeartRateZone]
    var isCustomizing: Bool = false // To differentiate between selection and customization
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.appCream.ignoresSafeArea()
            
            VStack {
                headerView
                
                Text(isCustomizing ? "Heart Rate Zones Range" : "Heart Rate Alert")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla imperdiet sodales purus.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                List {
                    ForEach($zones) { $zone in
                        if isCustomizing {
                            HRZoneCustomizeRow(zone: $zone)
                        } else {
                            HRZoneSelectRow(zone: $zone)
                        }
                    }
                    .listRowBackground(Color.white)
                    .listRowSeparator(.hidden)
                }
                .listStyle(InsetGroupedListStyle())
                .background(Color.appCream)
                .scrollContentBackground(.hidden)

                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text(isCustomizing ? "Customize Zone Range" : "Set")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(isCustomizing ? .orange : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isCustomizing ? Color.white : Color.orange)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isCustomizing ? Color.orange : Color.clear, lineWidth: 2)
                        )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }

    private var headerView: some View {
        HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: isCustomizing ? "xmark" : "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding()
    }
}

struct HRZoneSelectRow: View {
    @Binding var zone: HeartRateZone
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zone.name)
                    .font(.headline)
                Text("\(zone.lowerBPM)-\(zone.upperBPM) bpm")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if zone.isEnabled {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            zone.isEnabled.toggle()
        }
    }
}

struct HRZoneCustomizeRow: View {
    @Binding var zone: HeartRateZone
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(zone.name)
                .font(.headline)
                .foregroundColor(Color.zoneColors[Int(zone.name.last!.wholeNumberValue!) - 1])
            HStack {
                Text("\(zone.lowerBPM) - \(zone.upperBPM) bpm")
                Spacer()
                Button(action: { zone.lowerBPM -= 1; zone.upperBPM -= 1 }) {
                    Image(systemName: "minus.circle")
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Button(action: { zone.lowerBPM += 1; zone.upperBPM += 1 }) {
                    Image(systemName: "plus.circle")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}

// A wrapper is needed to hold the @State for the @Binding in the preview
fileprivate struct HRZonesView_PreviewWrapper: View {
    @State private var previewZones = UserSettings().heartRateZones
    var isCustomizing: Bool
    
    var body: some View {
        HRZonesView(zones: $previewZones, isCustomizing: isCustomizing)
    }
}

#Preview("Selection Mode") {
    HRZonesView_PreviewWrapper(isCustomizing: false)
}

#Preview("Customization Mode") {
    HRZonesView_PreviewWrapper(isCustomizing: true)
}
