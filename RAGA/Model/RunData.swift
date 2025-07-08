//
//  RunData.swift
//  RAGA
//
//  Created by Aditbalboa on 7/8/25.
//

import Foundation

// Data for a completed run session
struct RunData {
    var totalDuration: TimeInterval
    var totalDistance: Double // in KM
    var averagePace: Pace
    var averageHeartRate: Int
    var timeInZones: [TimeInterval] // Time in Zone 1, 2, 3, 4, 5
    
    // Formatted Strings for UI
    var formattedTotalTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: totalDuration) ?? "00:00:00"
    }
    
    var formattedTotalDistance: String {
        String(format: "%.2f", totalDistance)
    }
    
    var formattedAvgPace: String {
        "\(averagePace.minutes)'\(String(format: "%02d", averagePace.seconds))\" KM"
    }
    
    var formattedAvgHR: String {
        "\(averageHeartRate) BPM"
    }
    
    static var mock: RunData {
        RunData(
            totalDuration: 5025, // 01:23:45
            totalDistance: 8.40,
            averagePace: Pace(minutes: 7, seconds: 45),
            averageHeartRate: 155,
            timeInZones: [0, 2400, 1440, 60, 600] // 0s, 40m, 24m, 1m, 10m
        )
    }
}
