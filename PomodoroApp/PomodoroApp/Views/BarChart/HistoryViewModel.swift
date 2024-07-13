//
//  HistoryViewModel.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 23/05/24.
//

import SwiftUI
import Combine

class HistoryViewModel: ObservableObject {
    var timers: [CustomTime]
    private var cancellables = Set<AnyCancellable>()
    @Published var filterTimers: [CustomTime] = []
    @Published var formatedTimers: [StudyDataPoint] = []
    @Published var totalTime: String = ""
    @Published var breakTime: String = ""
    @Published var focusTime: String = ""
    @Published var daily: Bool = false
    

    init() {
        self.timers = []
        self.timers = DataManager.loadTimerHistory() ?? []
        
        filterTimersForTodayOrWeek()
        formatTotalTime()
        formatTimer()
        observeRecipeChanges()
    }
    
    private func observeRecipeChanges() {
        DataManager.historyDidChange
            .sink { [weak self] _ in
                self?.updateChart()
            }
            .store(in: &cancellables)
    }
    
    func formatTimer() {
        var studyDataPoints: [StudyDataPoint] = []
        
        for timer in filterTimers {
            guard let day = dayAndMonthFromDateString(dateString: timer.startTime) else { return }
            let hours = Float(timer.focusTime * timer.rounds)  / 60
            let focusDataPoint = StudyDataPoint(day: day, hours: hours)
            
            
            let breakHours = Float((timer.quickStop * timer.rounds - 1 ) + timer.longStop) / 60
            let breakDataPoint = StudyDataPoint(day: day, hours: breakHours, type: "Break")
            
            studyDataPoints.append(focusDataPoint)
            studyDataPoints.append(breakDataPoint)
        }
        
        self.formatedTimers =  studyDataPoints
    }
    
    func dayAndMonthFromDateString(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM"  // Formato para dia e mês
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func formatTotalTime() {
        var focusTmp: Float = 0
        var breakTmp: Float = 0
        for timer in filterTimers {
            focusTmp += Float(timer.focusTime * timer.rounds)  / 60
            breakTmp += Float((timer.quickStop * timer.rounds - 1 ) + timer.longStop) / 60
        }
        let totalTmp = breakTmp + focusTmp
        self.focusTime = "\(formattedNumber(number: focusTmp))h"
        self.breakTime = "\(formattedNumber(number: breakTmp))h"
        self.totalTime = "\(formattedNumber(number: totalTmp))h"
    }
    
    func formattedNumber(number: Float) -> String {
        let roundedNumber = floor(number * 10) / 10
        return String(format: "%.1f", roundedNumber)
    }
    
    func filterTimersForTodayOrWeek() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")

        let now = Date()
        let currentCalendar = Calendar.current

        filterTimers = timers.filter { timer in
            if let date = dateFormatter.date(from: timer.startTime) {
                if daily {
                    return currentCalendar.isDateInToday(date)
                } else {
                    let weekOfYearNow = currentCalendar.component(.weekOfYear, from: now)
                    let yearNow = currentCalendar.component(.year, from: now)
                    let weekOfYearTimer = currentCalendar.component(.weekOfYear, from: date)
                    let yearTimer = currentCalendar.component(.year, from: date)

                    return weekOfYearNow == weekOfYearTimer && yearNow == yearTimer
                }
            }
            return false
        }
    }
    
    func weekRangeText() -> String {
        let calendar = Calendar.current
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        // Encontrar o início da semana
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return "Data não disponível"
        }
        
        // Calcular o fim da semana
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return "Data não disponível"
        }
        
        // Formatar as datas
        let startFormat = dateFormatter.string(from: startOfWeek)
        let endFormat = dateFormatter.string(from: endOfWeek)
        
        // Retornar o texto formatado
        return "Semana do dia \(startFormat) - \(endFormat)"
    }
    
    func updateChart() {
        filterTimersForTodayOrWeek()
        formatTimer()
        formatTotalTime()
    }
}
