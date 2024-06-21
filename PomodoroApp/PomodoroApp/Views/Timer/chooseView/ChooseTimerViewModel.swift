//
//  ChooseTimerViewModel.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 22/05/24.
//

import Foundation
import Combine

class ChooseTimerViewModel: ObservableObject {
    @Published var timerActive: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        observeTimerChanges()
    }
    
    private func observeTimerChanges() {
        DataManager.timerDidChange
            .sink { [weak self] _ in
                self?.loadTimer()
            }
            .store(in: &cancellables)
    }
    
    func loadTimer() {
        self.timerActive = DataManager.loadTimer() != nil
    }
}
