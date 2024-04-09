//
//  PomodoroViewFactory.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation
import SwiftUI

class PomodoroViewFactory {
    
    static func setViewForDestination(_ destination: PomodoroNavigation) -> AnyView {
        
        switch destination {
        case .aboutView:
            return AnyView(AboutView())
        case .historyView:
            return AnyView(AboutView())
        case .timerView:
            return AnyView(ConfigTimerView())
        }
    }
}
