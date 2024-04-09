//
//  NavigationTab.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PomodoroViewFactory.setViewForDestination(.timerView)
                .tabItem {
                    Label("Timer", image: "icClock")
                }
            
            PomodoroViewFactory.setViewForDestination(.historyView)
                .tabItem {
                    Label("History", image: "icHistory")
                }
            
            PomodoroViewFactory.setViewForDestination(.aboutView)
                .tabItem {
                    Label("About", image: "icFind")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
