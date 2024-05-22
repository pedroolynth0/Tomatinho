//
//  choosePomodoroView.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 22/05/24.
//

import SwiftUI


struct ChoosePomodoroView: View {
    @StateObject var viewModel = ChooseTimerViewModel()

    
    var body: some View {
        VStack {
            if viewModel.timerActive {
                PomodoroTimerView()
            } else {
                ConfigTimerView()
            }
        }
        .onAppear() {
            viewModel.loadTimer()
        }
    }
    
}

#Preview {
    ChoosePomodoroView()
}
