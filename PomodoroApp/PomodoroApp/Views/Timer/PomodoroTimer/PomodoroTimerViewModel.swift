//
//  PomodoroTimerViewModel.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
//

import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    @Published var timeRemaining: CGFloat = 0
    @Published var currentPhase: String
    
    var dataManager = DataManager()
    var customTime: CustomTime = CustomTime(startTime: "08:00", focusTime: 1, quickStop: 20, longStop: 20, rounds: 1)
    var result = (stage: "", remainingTimeFormated: "", remainingTime: 0, currentRound: 0)
    

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        self.timeRemaining = CGFloat(customTime.focusTime)
        self.currentPhase = "Focus"
        loadTimer()
        updateTimer()
    }
    
    func updateTimer() {
        result = customTime.getCurrentStageAndTime()
        timeRemaining = CGFloat(result.remainingTime)
        currentPhase = result.stage
    }

    func totalTimeCompleted() -> CGFloat {
        return timeRemaining / CGFloat(customTime.stringToInt(currentPhase))
    }
    
    func tick() {
        updateTimer()
    }
    
    func loadTimer() {
        if let load = DataManager.loadTimer() {
            self.customTime = load
        } else {
            self.customTime = CustomTime(startTime: "Nil", focusTime: 0, quickStop: 0, longStop: 0, rounds: 0)
        }
    }
    
    func removeTimer() {
        do {
            try DataManager.clearCache()
            loadTimer()
        } catch {
            
        }
    }

}
