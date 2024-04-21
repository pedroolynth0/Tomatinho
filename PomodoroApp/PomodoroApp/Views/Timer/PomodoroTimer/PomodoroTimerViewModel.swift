//
//  PomodoroTimerViewModel.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    var customTime: CustomTime = CustomTime(startTime: "08:00", focusTime: 20, quickStop: 20, longStop: 20, rounds: 1)
    
    
    @Published var timeRemaining: CGFloat = 0
    @Published var currentTime: CGFloat
    @Published var currentPhase: String
    @Published var currentRound: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(customTime: CustomTime) {
        self.customTime = customTime
        self.timeRemaining = CGFloat(customTime.focusTime)
        self.currentPhase = "Focus"
        self.currentRound = 1
        self.currentTime = CGFloat(customTime.focusTime)
    }
    
    func convertToSec(timeValue: TimeValue) -> CGFloat {
       return CGFloat(timeValue.minutes * 60) + CGFloat(timeValue.seconds)
    }
    
    func timeFormatted(from totalSeconds: CGFloat) -> String {
        let totalSecondsInt = Int(totalSeconds)
        let minutes = totalSecondsInt / 60
        let seconds = totalSecondsInt % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func totalTimeCompleted() -> CGFloat {
        return timeRemaining / currentTime
    }
    
    
    func tick() {
        timeRemaining > 0 ? timeRemaining -= 1 : switchToNextPhase()
    }
    
    func switchToNextPhase() {
        if currentPhase == "Focus" {
            if currentRound % customTime.rounds == 0 {
                currentPhase = "Long Break"
                timeRemaining = CGFloat(customTime.longStop)
                self.currentTime = CGFloat(customTime.longStop)
            } else {
                currentPhase = "Short Break"
                timeRemaining = CGFloat(customTime.quickStop)
                self.currentTime = CGFloat(customTime.quickStop)
            }
        } else {
            currentPhase = "Focus"
            timeRemaining = CGFloat(customTime.focusTime)
            self.currentTime = CGFloat(customTime.focusTime)
            currentRound += 1
        }
    }

}
