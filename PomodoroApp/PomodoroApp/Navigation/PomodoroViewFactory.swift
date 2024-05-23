//
//  PomodoroViewFactory.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
//

import Foundation
import SwiftUI

class PomodoroViewFactory {
    
    static func setViewForDestination(_ destination: PomodoroNavigation) -> AnyView {
        
        switch destination {
        case .aboutView:
            return AnyView(AboutView())
        case .historyView:
            return AnyView(HistoryView())
        case .timerView:
            return AnyView(ChoosePomodoroView())
        case .pomodoroView:
            return AnyView(PomodoroTimerView())
        }
    }
}
