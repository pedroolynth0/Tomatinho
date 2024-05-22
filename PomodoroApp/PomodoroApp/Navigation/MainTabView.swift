//
//  NavigationTab.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var pomodoroFlow = PomodoroFlow()
    var body: some View {
        
        VStack(spacing: 0) {
            TabView {
                PomodoroViewFactory.setViewForDestination(.timerView)
                    .tabItem {
                        Label("Timer", systemImage: "timer")
                    }
                    .environmentObject(pomodoroFlow)
                
                PomodoroViewFactory.setViewForDestination(.aboutView)
                    .tabItem {
                        Label("History", systemImage: "text.book.closed.fill")
                    }

                    .environmentObject(pomodoroFlow)
                
                PomodoroViewFactory.setViewForDestination(.pomodoroView)
                    .tabItem {
                        Label("About", systemImage: "plus.magnifyingglass")
                    }
                    .environmentObject(pomodoroFlow)
            }
        }
        .onAppear{
            setupTabBarAppearance()
        }
    }
    

    func setupTabBarAppearance() {
        let standardAppearance = UITabBarAppearance()

        standardAppearance.configureWithOpaqueBackground() // Configurar aparência opaca
        standardAppearance.backgroundColor = .white // Cor de fundo do TabBar
        standardAppearance.shadowColor = .black.withAlphaComponent(0.5) // Cor da sombra do TabBar

        // Configurar a cor dos ícones para estado normal e selecionado
        standardAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.mainColor
        standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainColor]

        standardAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.playButton // Cor do ícone quando selecionado
        standardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.playButton]
        
        UITabBar.appearance().standardAppearance = standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = standardAppearance
    }

}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var pomodoroFlow = PomodoroFlow()
        MainTabView()
            .environmentObject(pomodoroFlow)
    }
}
