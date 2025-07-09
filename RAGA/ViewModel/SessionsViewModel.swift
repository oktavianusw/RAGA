import Foundation

class SessionsViewModel: ObservableObject {
    @Published var sessions: [RunData] = [
        RunData(totalDuration: 3600, totalDistance: 4.31, averagePace: Pace(minutes: 4, seconds: 45), averageHeartRate: 156, timeInZones: [0,0,0,0,0]),
        RunData(totalDuration: 4200, totalDistance: 5.20, averagePace: Pace(minutes: 5, seconds: 0), averageHeartRate: 165, timeInZones: [0,0,0,0,0]),
        RunData(totalDuration: 4500, totalDistance: 5.40, averagePace: Pace(minutes: 5, seconds: 10), averageHeartRate: 143, timeInZones: [0,0,0,0,0])
    ]
    
    // MARK: - Aggregated Stats
    var totalDistance: Double {
        sessions.reduce(0) { $0 + $1.totalDistance }
    }
    
    var highestDistance: Double {
        sessions.map { $0.totalDistance }.max() ?? 0
    }
    
    var highestPace: Pace? {
        sessions.map { $0.averagePace }.min(by: { $0.minutes * 60 + $0.seconds < $1.minutes * 60 + $1.seconds })
    }
    
    // MARK: - Formatted Strings
    var formattedTotalDistance: String {
        String(format: "%.2f", totalDistance).replacingOccurrences(of: ".", with: ",")
    }
    
    var formattedHighestDistance: String {
        String(format: "%.2f", highestDistance).replacingOccurrences(of: ".", with: ",")
    }
    
    var formattedHighestPace: String {
        guard let pace = highestPace else { return "-" }
        return String(format: "%d'%02d'' /KM", pace.minutes, pace.seconds)
    }
} 