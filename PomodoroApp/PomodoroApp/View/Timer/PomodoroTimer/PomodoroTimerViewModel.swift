//
//  PomodoroTimerViewModel.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    @Published var currentTime: TimeValue
    @Published var totalTime: TimeValue
    
    init(currentTime: TimeValue, totalTime: TimeValue) {
        self.currentTime = currentTime
        self.totalTime = totalTime
    }
    
    func convertToSec(timeValue: TimeValue) -> CGFloat {
       return CGFloat(timeValue.minutes * 60) + CGFloat(timeValue.seconds)
    }
    
    func totalTimeCompleted() -> CGFloat {
        return convertToSec(timeValue: currentTime) / convertToSec(timeValue: totalTime)
    }
}
