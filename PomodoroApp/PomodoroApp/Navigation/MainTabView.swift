//
//  NavigationTab.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var pomodoroFlow = PomodoroFlow()
    var body: some View {
        TabView {
            PomodoroViewFactory.setViewForDestination(.timerView)
                .tabItem {
                    Label("Timer", image: "icClock")
                }
                .environmentObject(pomodoroFlow)
            
            PomodoroViewFactory.setViewForDestination(.historyView)
                .tabItem {
                    Label("History", image: "icHistory")
                }
                .environmentObject(pomodoroFlow)
            
            PomodoroViewFactory.setViewForDestination(.pomodoroView)
                .tabItem {
                    Label("About", image: "icFind")
                }
                .environmentObject(pomodoroFlow)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var pomodoroFlow = PomodoroFlow()
        MainTabView()
            .environmentObject(pomodoroFlow)
    }
}
