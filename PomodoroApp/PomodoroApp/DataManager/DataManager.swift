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
    private static let archiveURL = documentsDirectory.appendingPathComponent("timer").appendingPathExtension("plist")
    
    static let timerDidChange = PassthroughSubject<Void, Never>()
    
    
    
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
}
