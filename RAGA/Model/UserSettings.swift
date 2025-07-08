//
//  UserSettings.swift
//  RAGA
//
//  Created by Aditbalboa on 7/8/25.
//

import Foundation
import Combine

// Represents a single heart rate zone
struct HeartRateZone: Identifiable, Codable {
    var id = UUID()
    let name: String
    var lowerBPM: Int
    var upperBPM: Int
    var isEnabled: Bool = true
}

// Represents pace in minutes and seconds
struct Pace: Codable, Equatable {
    var minutes: Int
    var seconds: Int

    var displayString: String {
        String(format: "%d'%02d\"", minutes, seconds)
    }
}

// Main settings object
class UserSettings: ObservableObject {
    @Published var name: String = "Subagio"
    @Published var age: Int = 25
    @Published var gender: String = "Male"

    @Published var heartRateAlertOn: Bool = true
    @Published var audioGuidanceOn: Bool = true // Generic audio guidance
    
    @Published var heartRateZones: [HeartRateZone] = [
        HeartRateZone(name: "Zone 1", lowerBPM: 110, upperBPM: 126),
        HeartRateZone(name: "Zone 2", lowerBPM: 110, upperBPM: 126),
        HeartRateZone(name: "Zone 3", lowerBPM: 110, upperBPM: 126),
        HeartRateZone(name: "Zone 4", lowerBPM: 110, upperBPM: 126),
        HeartRateZone(name: "Zone 5", lowerBPM: 110, upperBPM: 126)
    ]

    @Published var paceAlertOn: Bool = true
    @Published var upperPaceLimit: Pace = Pace(minutes: 8, seconds: 30)
    @Published var lowerPaceLimit: Pace = Pace(minutes: 9, seconds: 0)
}
