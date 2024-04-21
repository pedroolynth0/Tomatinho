//
//  PomodoroAppApp.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

@main
struct PomodoroAppApp: App {
    @StateObject var pomodoroFlow = PomodoroFlow()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(pomodoroFlow)
        }
    }
}
