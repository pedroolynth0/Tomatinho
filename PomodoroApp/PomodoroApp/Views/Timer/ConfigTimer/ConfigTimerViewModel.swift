//
//  ConfigTimerViewModel.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

class ConfigTimerViewModel: ObservableObject {
    @Published var customTime: CustomTime = CustomTime(startTime: "\(Date())", focusTime: 25, quickStop: 5, longStop: 30, rounds: 4)
    
    func removeRound() {
        self.customTime.rounds = max(0, customTime.rounds - 1)
    }
    
    func addRound() {
        self.customTime.rounds += 1
    }
    
    func addFocusTime() {
        customTime.focusTime += 1
        objectWillChange.send()
    }
    
    func removeFocusTime() {
        customTime.focusTime = max(0, customTime.focusTime - 1)
        objectWillChange.send()
    }

    func addQuickStop() {
        customTime.quickStop += 1
        objectWillChange.send()
    }
    
    func removeQuickStop() {
        customTime.quickStop = max(0, customTime.quickStop - 1)
        objectWillChange.send()
    }

    func addLongStop() {
        customTime.longStop += 1
        objectWillChange.send()
    }
    
    func removeLongStop() {
        customTime.longStop = max(0, customTime.longStop - 1)
        objectWillChange.send()
    }
    

    
}
