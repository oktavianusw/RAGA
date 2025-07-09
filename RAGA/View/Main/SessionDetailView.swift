import SwiftUI

struct SessionDetailView: View {
    let run: RunData
    @Environment(\.presentationMode) var presentationMode
    
    var dateTitle: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(run.date) {
            return "Today"
        } else if calendar.isDateInYesterday(run.date) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            return formatter.string(from: run.date)
        }
    }
    
    var body: some View {
        ZStack {
            Color(hex: "1E2F06").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        
                        Spacer()
                        Text(dateTitle)
                            .foregroundColor(Color(hex: "FFFADD"))
                            .font(.title3).bold()
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    // Summary Card
                    HStack(alignment: .top, spacing: 16) {
                        VStack {
                            Spacer()
                            Image(systemName: "figure.run")
                                .resizable()
                                .frame(width: 48)
                                .foregroundColor(Color(hex: "FFFADD"))
                            Spacer()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Outdoor Run")
                                .foregroundColor(Color(hex: "FFFADD"))
                                .font(.headline)
                            Text("Open Goal???")
                                .foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                .font(.subheadline)
                            Text("18:13–18:48")
                                .foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                .font(.caption)
                            HStack(spacing: 4) {
                                Image(systemName: "location.fill")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("Kabupaten Badung")
                                    .foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(hex: "6A8043").opacity(0.5))
                    .cornerRadius(20)
                    
                    // Workout Details Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Workout Details")
                            .font(.headline)
                            .foregroundColor(Color(hex: "FFFADD"))
                        Divider().background(Color(hex: "FFFADD").opacity(0.2))
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Workout Time")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text(run.formattedTotalTime)
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Distance")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("\(run.formattedTotalDistance) KM")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                        }
                        Divider().background(Color(hex: "FFFADD").opacity(0.2))
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Average Heart Rate")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("\(run.averageHeartRate) BPM")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Average Pace")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("\(run.formattedTotalDistance) KM") // You may want to use run.formattedAvgPace
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                        }
                        Divider().background(Color(hex: "FFFADD").opacity(0.2))
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Below Target Alert Heart Rate")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("1 Times")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Above Target Alert Heart Rate")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("3 Times")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                        }
                        Divider().background(Color(hex: "FFFADD").opacity(0.2))
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Below Target Alert Pace")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("2 Times")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Above Target Alert Pace")
                                    .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                                Text("4 Times")
                                    .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                            }
                        }
                    }
                    .padding()
                    .background(Color(hex: "6A8043").opacity(0.5))
                    .cornerRadius(20)
                    
                    // Heart Rate Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Heart Rate")
                            .font(.headline)
                            .foregroundColor(Color(hex: "FFFADD"))
                        Divider().background(Color(hex: "FFFADD").opacity(0.2))
                        Text("Average Heart Rate")
                            .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                        Text("\(run.averageHeartRate) BPM")
                            .font(.title2).bold().foregroundColor(Color(hex: "FFFADD"))
                        // Dummy heart rate chart
                        Text("Heart Rate")
                            .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                        Rectangle()
                            .fill(Color(hex: "FFFADD").opacity(0.3))
                            .frame(height: 80)
                            .cornerRadius(8)
                            .overlay(Text("[Chart]").foregroundColor(Color(hex: "FFFADD").opacity(0.7)))
                        // Zones
                        Text("Zones")
                            .font(.caption2).foregroundColor(Color(hex: "FFFADD").opacity(0.7))
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(0..<run.timeInZones.count, id: \.self) { i in
                                let minutes = Int(run.timeInZones[i] / 60)
                                if minutes > 0 {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(zoneColor(index: i))
                                            .frame(width: 30, height: 20)
                                            .overlay(Text("\(i+1)").font(.caption2).foregroundColor(.white))
                                        Text("\(minutes) mins")
                                            .font(.caption2)
                                            .foregroundColor(Color(hex: "FFFADD"))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(hex: "6A8043").opacity(0.5))
                    .cornerRadius(20)
                }
                .padding()
            }
        }
    }
    
    func zoneColor(index: Int) -> Color {
        switch index {
        case 0: return Color.blue
        case 1: return Color.green
        case 2: return Color.yellow
        case 3: return Color.orange
        case 4: return Color.red
        default: return Color.gray
        }
    }
}

// Preview
struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(run: RunData.mock)
    }
} 
