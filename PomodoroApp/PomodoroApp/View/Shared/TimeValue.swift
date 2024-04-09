//
//  TimeValue.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//
import SwiftUI

class TimeValue {
    var minutes: Int
    var seconds: Int
    
    var formattedData: String {
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Inicializador que evita minutos e segundos inválidos
    init(minutes: Int, seconds: Int) {
        self.minutes = max(0, minutes) // Evita valores negativos
        self.seconds = max(0, seconds) % 60 // Mantém os segundos válidos
        self.minutes += seconds / 60 // Adiciona minutos extras se os segundos > 59
    }
}
