//
//  PomodoroFlow.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation
import SwiftUI

class PomodoroFlow: ObservableObject {
    static let shared = PomodoroFlow()
    var customTimer: CustomTime = CustomTime(startTime: "", focusTime: 1, quickStop: 1, longStop: 1, rounds: 1)
    
    @Published var path = NavigationPath()
    
    func clear() {
        path = .init()
    }
    
    func sendCustomTimer() -> String {
        var customTimerList: String = ""
        customTimerList += ("\(customTimer.rounds),")
        customTimerList += ("\(customTimer.focusTime),")
        customTimerList += ("\(customTimer.quickStop),")
        customTimerList += ("\(customTimer.longStop),")

        return customTimerList
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
        return dateFormatter.string(from: Date())
    }
    
    func saveTime(customTimer: CustomTime) {
        self.customTimer = customTimer
        self.customTimer.startTime = formatDate()
        DataManager.saveTimer(self.customTimer)
    }
    
    func navigateBackToRoot() {
        path.removeLast(path.count)
    }
    
    func backToPrevious() {
        path.removeLast()
    }
    
    func done() {
        path = .init()
    }
    
    func navigateToAboutView() {
        path.append(PomodoroNavigation.aboutView)
    }
    
    func navigateToHistoryView() {
        path.append(PomodoroNavigation.historyView)
    }
    
    func navigateToTimerView() {
        path.append(PomodoroNavigation.timerView)
    }
}

