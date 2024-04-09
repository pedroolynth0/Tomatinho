//
//  ConfigTimerViewModel.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

class ConfigTimerViewModel: ObservableObject {
    @Published var rounds: Int
    @Published var focusTime: TimeValue
    @Published var quickStop: TimeValue
    @Published var longStop: TimeValue
    
    init() {
        self.rounds = 4
        self.focusTime = TimeValue(minutes: 25, seconds: 0)
        self.quickStop = TimeValue(minutes: 5, seconds: 0)
        self.longStop = TimeValue(minutes: 30, seconds: 0)
    }
    
    func removeRound() {
        self.rounds = max(0, rounds - 1)
    }
    
    func addRound() {
        self.rounds += 1
    }
    
    func addFocusTime() {
        focusTime.minutes += 1
        objectWillChange.send()
    }
    
    func removeFocusTime() {
        focusTime.minutes = max(0, focusTime.minutes - 1)
        objectWillChange.send()
    }

    func addQuickStop() {
        quickStop.minutes += 1
        objectWillChange.send()
    }
    
    func removeQuickStop() {
        quickStop.minutes = max(0, quickStop.minutes - 1)
        objectWillChange.send()
    }

    func addLongStop() {
        longStop.minutes += 1
        objectWillChange.send()
    }
    
    func removeLongStop() {
        longStop.minutes = max(0, longStop.minutes - 1)
        objectWillChange.send()
    }
}
