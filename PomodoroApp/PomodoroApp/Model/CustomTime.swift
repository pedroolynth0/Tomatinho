//
//  Timer.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation

struct CustomTime: Codable {
    let startTime: String
    let focusTime: Int
    let quickStop: Int
    let longStop: Int
    let rounds: Int
    
    init(startTime: String, focusTime: Int, quickStop: Int, longStop: Int, rounds: Int) {
        self.startTime = startTime
        self.focusTime = focusTime
        self.quickStop = quickStop
        self.longStop = longStop
        self.rounds = rounds
    }
}
