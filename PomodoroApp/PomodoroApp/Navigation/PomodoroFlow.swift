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
    var customTimer: CustomTime = CustomTime(startTime: "08:00", focusTime: 25, quickStop: 5, longStop: 30, rounds: 4)
    
    @Published var path = NavigationPath()
    
    func clear() {
        path = .init()
    }
    
    func sendCustomTimer() -> [Int] {
        var customTimerList: [Int] = []
        customTimerList.append(customTimer.focusTime)
        customTimerList.append(customTimer.quickStop)
        customTimerList.append(customTimer.longStop)
        customTimerList.append(customTimer.rounds)
        
        return customTimerList
    }
    
    func intListToData() -> Data {
        let intList = sendCustomTimer()
        var data = Data()

        for number in intList {
            var littleEndianInt = UInt32(number).littleEndian // Certifique-se do formato Little Endian
            data.append(Data(bytes: &littleEndianInt, count: MemoryLayout<UInt32>.size))
        }

        return data
    }

    
    func saveTime(customTimer: CustomTime) -> Data {
        self.customTimer = customTimer
        let timer = "\(customTimer.rounds),\(customTimer.focusTime),\(customTimer.quickStop),\(customTimer.longStop)"
        guard let data = timer.data(using: .utf8) else { return Data() }
        return data
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

