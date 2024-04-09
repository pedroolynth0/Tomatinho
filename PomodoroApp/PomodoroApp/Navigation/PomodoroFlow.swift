//
//  PomodoroFlow.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation
import SwiftUI

class RecipeFlow: ObservableObject {
    static let shared = RecipeFlow()
    
    @Published var path = NavigationPath()
    
    func clear() {
        path = .init()
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

