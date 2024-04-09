//
//  PomodoroTimerView.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import SwiftUI

struct PomodoroTimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel(currentTime: TimeValue(minutes: 14, seconds: 0), totalTime: TimeValue(minutes: 24, seconds: 00))
    
    var body: some View {
        
        VStack(spacing: 100) {
            TitleView(title: "Pomodoro Timer")
                .padding(.top, 29)
            circles
                .frame(width: 350)
            Spacer()
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
                .animation(.linear, value: viewModel.convertToSec(timeValue: viewModel.currentTime))
            
            VStack {
                Text("\(viewModel.currentTime.formattedData)")
                    .font(.custom("ZillaSlab-Bold", size: 48))
                
                Text("Foco Total")
                    .font(.custom("ZillaSlab-Medium", size: 20))
            }
        }
        .padding(60)
    }
}

#Preview {
    PomodoroTimerView()
}
