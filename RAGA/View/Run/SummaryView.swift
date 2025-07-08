import SwiftUI

struct SummaryView: View {
    @Binding var isPresented: Bool // Binding to control the sheet
    
    let runData = RunData.mock
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Great Work!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla imperdiet sodales purus. Pellentesque habitant morbi tristique.")
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    
                    // Illustration Placeholder
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 100)
                        .cornerRadius(20)
                        .overlay(Text("Illustration Placeholder").foregroundColor(.white))
                    
                    summaryMetrics
                    
                    doneButton
                    
                    zoneSummary
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    private var summaryMetrics: some View {
        VStack(spacing: 25) {
            SummaryMetricRow(icon: "clock.fill", title: "TOTAL TIME", value: runData.formattedTotalTime)
            SummaryMetricRow(icon: "figure.run", title: "TOTAL DISTANCE", value: runData.formattedTotalDistance + " KM")
            SummaryMetricRow(icon: "speedometer", title: "AVERAGE PACE", value: runData.formattedAvgPace)
            SummaryMetricRow(icon: "heart.fill", title: "AVERAGE HEART RATE", value: runData.formattedAvgHR)
        }
    }
    
    private var doneButton: some View {
        Button(action: {
            isPresented = false // This will dismiss the entire sheet
        }) {
            Text("Done")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.appGreen)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.appCream)
                .cornerRadius(15)
        }
    }
    
    private var zoneSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Adjusted logic to avoid index out of bounds for the mock data
            let displayableZones = min(runData.timeInZones.count, Color.zoneColors.count)
            ForEach(1..<displayableZones) { index in
                let timeInMinutes = runData.timeInZones[index] / 60
                if timeInMinutes > 0 {
                    HStack {
                        Text("\(index + 1)")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.zoneColors[index])
                            .cornerRadius(5)
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.zoneColors[index])
                                    .frame(width: geo.size.width * (timeInMinutes / 40.0))
                                    .cornerRadius(5)
                            }
                        }
                        
                        Text("\(Int(timeInMinutes)) mins")
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
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
}


fileprivate struct SummaryView_PreviewWrapper: View {
    @State private var isPresented = true
    
    var body: some View {
        SummaryView(isPresented: $isPresented)
            .environmentObject(UserSettings())
    }
}

#Preview {
    SummaryView_PreviewWrapper()
}
