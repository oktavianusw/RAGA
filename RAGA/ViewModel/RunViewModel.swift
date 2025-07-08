//
//  RunViewModel.swift
//  RAGA
//
//  Created by Aditbalboa on 7/8/25.
//

import Foundation
import Combine

class RunViewModel: ObservableObject {
    @Published var totalDuration: TimeInterval = 0
    @Published var totalDistance: Double = 0.0 // in KM
    
    @Published var currentHeartRate: Int = 120
    @Published var currentPace: Pace = Pace(minutes: 9, seconds: 20)
    @Published var currentZone: Int = 1
    
    @Published var isRunning = false
    @Published var isFinished = false
    
    private var timer: AnyCancellable?
    private var runSettings: UserSettings
    
    init(settings: UserSettings) {
        self.runSettings = settings
    }
    
    func startRun() {
        isRunning = true
        isFinished = false
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateMetrics()
            }
    }
    
    func pauseRun() {
        isRunning = false
        timer?.cancel()
    }
    
    func resumeRun() {
        startRun()
    }
    
    func stopRun() {
        isRunning = false
        isFinished = true
        timer?.cancel()
        // Here you would finalize the run data
    }
    
    private func updateMetrics() {
        // --- SIMULATED DATA ---
        totalDuration += 1
        
        // Simulate distance increase (avg speed ~6-7 min/km)
        totalDistance += 0.0025
        
        // Simulate heart rate fluctuation
        currentHeartRate += Int.random(in: -2...2)
        if currentHeartRate < 80 { currentHeartRate = 80 }
        if currentHeartRate > 180 { currentHeartRate = 180 }
        
        // Simulate pace fluctuation
        let paceChange = Int.random(in: -1...1)
        var newSeconds = currentPace.seconds + paceChange
        if newSeconds > 59 {
            currentPace.minutes += 1
            newSeconds = 0
        } else if newSeconds < 0 {
            currentPace.minutes -= 1
            newSeconds = 59
        }
        currentPace.seconds = newSeconds
        
        // Simulate zone change
        if currentHeartRate < 126 { currentZone = 1 }
        else if currentHeartRate < 135 { currentZone = 2 }
        else if currentHeartRate < 145 { currentZone = 3 }
        else if currentHeartRate < 155 { currentZone = 4 }
        else { currentZone = 5 }
        
        // Check for alerts (in a real app, this would trigger sound/haptics)
        checkAlerts()
    }
    
    private func checkAlerts() {
        // Simple print statements to simulate alerts
        if runSettings.paceAlertOn {
            if currentPace.minutes > runSettings.lowerPaceLimit.minutes {
                print("ALERT: Pace too slow!")
            }
            if currentPace.minutes < runSettings.upperPaceLimit.minutes {
                 print("ALERT: Pace too fast!")
            }
        }
        
        if runSettings.heartRateAlertOn {
            // This is a simplified check. A real app would check against selected zones.
            let zoneSettings = runSettings.heartRateZones[currentZone - 1]
            if currentHeartRate < zoneSettings.lowerBPM || currentHeartRate > zoneSettings.upperBPM {
                 // print("ALERT: Heart rate out of selected zone!")
            }
        }
    }
    
    // Formatters for display
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: totalDuration) ?? "00:00:00"
    }
    
    var formattedDistance: String {
        return String(format: "%.2f", totalDistance).replacingOccurrences(of: ".", with: ",")
    }
}
