//
//  SettingsViewModel.swift
//  RAGA
//
//  Created by Aditbalboa on 7/8/25.
//

import Foundation
import Combine

// This ViewModel is primarily for the RecordRun view to prepare for a run.
// It uses the global UserSettings as its source of truth.
class SettingsViewModel: ObservableObject {
    @Published var settings: UserSettings
    
    private var cancellables = Set<AnyCancellable>()
    
    init(settings: UserSettings) {
        self.settings = settings
        
        // This ensures that if settings are changed elsewhere, this ViewModel reflects it.
        settings.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    var enabledZonesSummary: String {
        let enabled = settings.heartRateZones.filter { $0.isEnabled }
        if enabled.count == settings.heartRateZones.count {
            return "All"
        }
        return enabled.map { $0.name.replacingOccurrences(of: "Zone ", with: "") }.joined(separator: ", ")
    }
}
