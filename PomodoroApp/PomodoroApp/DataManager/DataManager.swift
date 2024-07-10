//
//  DataManager.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
//

import Foundation
import Combine


struct DataManager {
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let lastTimeArchiveURL = documentsDirectory.appendingPathComponent("lastTimer").appendingPathExtension("plist")
    private static let archiveURL = documentsDirectory.appendingPathComponent("timer").appendingPathExtension("plist")
    private static let historyURL = documentsDirectory.appendingPathComponent("timerHistory").appendingPathExtension("plist")
    static let timerDidChange = PassthroughSubject<Void, Never>()
    static let historyDidChange = PassthroughSubject<Void, Never>()
    
    
    static func saveLastTimer(_ customTime: CustomTime) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(customTime)
            try data.write(to: lastTimeArchiveURL, options: .noFileProtection)
        } catch {
            print("erro")
        }
    }
     
    static func loadLastTimer() -> CustomTime {
        do {
            let data = try Data(contentsOf: lastTimeArchiveURL)
            let decoder = PropertyListDecoder()
            return try decoder.decode(CustomTime.self, from: data)
        } catch {
            return CustomTime(startTime: "", focusTime: 25, quickStop: 5, longStop: 30, rounds: 4)
        }
    }
    
    static func saveTimer(_ customTime: CustomTime) {
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(customTime)
            try data.write(to: archiveURL, options: .noFileProtection)
            timerDidChange.send()
        } catch {
            print("erro")
        }
    }
    
    static func clearCache() throws {
        try FileManager.default.removeItem(at: archiveURL)
        timerDidChange.send()
    }
    
    
    static func updateTimer(_ updatedTimer: CustomTime) throws {
        var existingTimer = loadTimer()
        
        existingTimer = updatedTimer
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(existingTimer)
            try data.write(to: archiveURL, options: .noFileProtection)
            timerDidChange.send()
        }
    }
    
    
    static func loadTimer() -> CustomTime? {
        do {
            let data = try Data(contentsOf: archiveURL)
            let decoder = PropertyListDecoder()
            return try decoder.decode(CustomTime.self, from: data)
        } catch {
            return nil
        }
    }
    
    static func addTimerToHistory(_ timer: CustomTime) {
        var timersHistory = loadTimerHistory() ?? []
        timersHistory.append(timer)
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(timersHistory)
            try data.write(to: historyURL, options: .noFileProtection)
            historyDidChange.send()
        } catch {
            print("Erro ao adicionar timer ao histórico")
        }
    }
    
    static func loadTimerHistory() -> [CustomTime]? {
        do {
            let data = try Data(contentsOf: historyURL)
            let decoder = PropertyListDecoder()
            return try decoder.decode([CustomTime].self, from: data)
        } catch {
            print("Erro ao carregar histórico de timers")
            return nil
        }
    }
    
    static func clearHistory() {
        do {
            try FileManager.default.removeItem(at: historyURL)
        } catch {
            print("Não foi possivel apagar o historico")
        }
        timerDidChange.send()
    }
}
