import SwiftUI

struct SummaryView: View {
    let onDone: () -> Void
    
    let runData = RunData.mock
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Great Work!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla imperdiet sodales purus. Pellentesque habitant morbi tristique.")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                // Illustration Placeholder
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 60)
                    .cornerRadius(12)
                    .overlay(Text("Illustration Placeholder").font(.caption2).foregroundColor(.white))
                
                summaryMetrics
                
                doneButton
                
                zoneSummary
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    private var summaryMetrics: some View {
        VStack(spacing: 12) {
            SummaryMetricRow(icon: "clock.fill", title: "TOTAL TIME", value: runData.formattedTotalTime)
            SummaryMetricRow(icon: "figure.run", title: "TOTAL DISTANCE", value: runData.formattedTotalDistance + " KM")
            SummaryMetricRow(icon: "speedometer", title: "AVERAGE PACE", value: runData.formattedAvgPace)
            SummaryMetricRow(icon: "heart.fill", title: "AVERAGE HEART RATE", value: runData.formattedAvgHR)
        }
    }
    
    private var doneButton: some View {
        Button(action: {
            onDone()
        }) {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.appGreen)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color.appCream)
                .cornerRadius(12)
        }
    }
    
    private var zoneSummary: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Adjusted logic to avoid index out of bounds for the mock data
            let displayableZones = min(runData.timeInZones.count, Color.zoneColors.count)
            ForEach(1..<displayableZones) { index in
                let timeInMinutes = runData.timeInZones[index] / 60
                if timeInMinutes > 0 {
                    HStack {
                        Text("\(index + 1)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.zoneColors[index])
                            .cornerRadius(4)
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.zoneColors[index])
                                    .frame(width: geo.size.width * (timeInMinutes / 40.0))
                                    .cornerRadius(4)
                            }
                        }
                        
                        Text("\(Int(timeInMinutes)) mins")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

// THIS WAS THE MISSING PIECE
struct SummaryMetricRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
}


fileprivate struct SummaryView_PreviewWrapper: View {
    var body: some View {
        SummaryView(onDone: {})
            .environmentObject(UserSettings())
    }
}

#Preview {
    SummaryView_PreviewWrapper()
}
