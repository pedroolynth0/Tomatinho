//
//  Timer.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation

struct Timer: Codable {
    let startTime: String
    let endTime: String
    let focusTime: String
    let quickStop: String
    let longStop: String
    let rounds: Int
    
    init(startTime: String, endTime: String, focusTime: String, quickStop: String, longStop: String, rounds: Int) {
        self.startTime = startTime
        self.endTime = endTime
        self.focusTime = focusTime
        self.quickStop = quickStop
        self.longStop = longStop
        self.rounds = rounds
    }
}
