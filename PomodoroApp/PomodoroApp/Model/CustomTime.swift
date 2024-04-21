//
//  Timer.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation

struct CustomTime: Codable {
    var startTime: String
    var focusTime: Int
    var quickStop: Int
    var longStop: Int
    var rounds: Int
    
    init(startTime: String, focusTime: Int, quickStop: Int, longStop: Int, rounds: Int) {
        self.startTime = startTime
        self.focusTime = focusTime
        self.quickStop = quickStop
        self.longStop = longStop
        self.rounds = rounds
    }
}
