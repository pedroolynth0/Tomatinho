//
//  PomodoroTimerView.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

struct PomodoroTimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel(customTime: CustomTime(startTime: "08:00", focusTime: 10 * 60, quickStop: 10 * 60 , longStop: 11, rounds: 1))
    
    var body: some View {
        
        VStack(spacing: 100) {
            TitleView(title: "Pomodoro Timer")
                .padding(.top, 29)
            circles
                .frame(width: 350)
            Spacer()
        }
        .onReceive(viewModel.timer) { time in
            viewModel.tick()
        }
    }
    
    var circles: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.2)
                .foregroundColor(Color.pink)
            
            Circle()
                .trim(from: 0.0, to: viewModel.totalTimeCompleted() )
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(Color.pink)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: viewModel.timeRemaining)
            
            VStack {
                Text("\(viewModel.timeFormatted(from: viewModel.timeRemaining))")
                    .font(.custom("ZillaSlab-Bold", size: 48))
                
                Text("\(viewModel.currentPhase)")
                    .font(.custom("ZillaSlab-Medium", size: 20))
            }
        }
        .padding(60)
    }
}

#Preview {
    PomodoroTimerView()
}
