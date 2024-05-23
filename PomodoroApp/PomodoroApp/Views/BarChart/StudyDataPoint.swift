//
//  StudyDataPoint.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 23/05/24.
//

import Foundation

struct StudyDataPoint: Identifiable {
    var id = UUID().uuidString
    var day: String
    var hours: Float
    var type: String = "Focus"
}
