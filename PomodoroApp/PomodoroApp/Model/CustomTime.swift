//
//  Timer.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
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
    
    func getCurrentStageAndTime() -> (stage: String, remainingTimeFormated: String, remainingTime: Int, currentRound: Int) {
        if startTime != "Nil" {
            let focusTimeSeconds = self.focusTime * 60
            let quickStopSeconds = self.quickStop * 60
            let longStopSeconds = self.longStop * 60
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateFormatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
            
            guard let start = dateFormatter.date(from: self.startTime) else {
                return ("", "", 0, 0)
            }
            
            let now = Date()
            let totalSeconds = Int(now.timeIntervalSince(start))
            
            if totalSeconds < 0 {
                return ("Error", "Start time is in the future", 0, 0)
            }
            
            var remainingSeconds = totalSeconds
            let totalRoundTime = focusTimeSeconds + quickStopSeconds
            let totalCycleTime = totalRoundTime * (self.rounds - 1) + focusTimeSeconds + longStopSeconds
            
            if totalSeconds >= totalCycleTime {
                do {
                    guard let timer = DataManager.loadTimer() else { return ("Finished", "", 0, self.rounds)}
                    DataManager.addTimerToHistory(timer)
                    try DataManager.clearCache()
                } catch {
                    print("Erro ao remover timer da memoria")
                }
                return ("Finished", "", 0, self.rounds)
            }
            
            var round = 1
            while remainingSeconds >= totalRoundTime  && totalRoundTime != 0 {
                remainingSeconds -= totalRoundTime
                round += 1
            }
            
            if remainingSeconds < focusTimeSeconds {
                let focusTimeLeft = focusTimeSeconds - remainingSeconds
                if focusTimeLeft % 60 < 10 {
                    return ("Foco", "\(focusTimeLeft / 60):0\(focusTimeLeft % 60)", focusTimeLeft, round)
                } else {
                    return ("Foco", "\(focusTimeLeft / 60):\(focusTimeLeft % 60)", focusTimeLeft, round)
                }
                
            } else  if round < rounds {
                let breakTime = totalRoundTime - remainingSeconds
                if breakTime % 60 < 10 {
                    return ("Short Break", "\(breakTime / 60):0\(breakTime % 60)", breakTime, round)
                } else {
                    return ("Short Break", "\(breakTime / 60):\(breakTime % 60)", breakTime, round)
                }
            } else {
                let breakTime =  longStopSeconds - remainingSeconds + 60
                if breakTime % 60 < 10 {
                    return ("Long Break", "\(breakTime / 60):0\(breakTime % 60)", breakTime, round)
                } else {
                    return ("Long Break", "\(breakTime / 60):\(breakTime % 60)", breakTime, round)
                }
            }
        } else {
            return ("", "Timer \n Config", 0, 0)
        }
    }
    
    func stringToInt(_ input: String) -> Int {
        switch input {
        case "Foco":
            return focusTime * 60
        case "Short Break":
            return quickStop * 60
        case "Long Break":
            return longStop * 60
        default:
            return 0
        }
    }
}
