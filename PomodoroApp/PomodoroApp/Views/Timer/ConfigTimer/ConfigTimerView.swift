//
//  ConfigTimerView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct ConfigTimerView: View {
    @EnvironmentObject var pomodoroFlow: PomodoroFlow
    @StateObject var viewModel = ConfigTimerViewModel()
    @StateObject var bluetoothManager = BluetoothManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 90) {
            TitleView(title: "Configuração Timer")
                .padding(.top, 29)
            gridTimers
            button
            Spacer()
        }
    }
    
    var button: some View {
        HStack {
            Spacer()
            Button(action: {
                bluetoothManager.sendData(pomodoroFlow.intListToData())
                pomodoroFlow.saveTime(customTimer: viewModel.customTime)
            }) {
                Image("play")
                    .foregroundStyle(Color.white)
                    .frame(width: 43, height: 43)
                    .padding(24)
                    .background(Color(UIColor.playButtonColor.asColor))
                    .clipShape(Circle())
            }
            Spacer()
        }
        
    }
    var gridTimers: some View {
        VStack(spacing: 50) {
            configItem(name: "Rounds", value: "\(viewModel.customTime.rounds)", subFunc: viewModel.removeRound, addFunc: viewModel.addRound)
            configItem(name: "Tempo de Foco", value: "\(viewModel.customTime.focusTime):00", subFunc: viewModel.removeFocusTime, addFunc: viewModel.addFocusTime)
            configItem(name: "Pausa Curta", value: "\(viewModel.customTime.quickStop):00", subFunc: viewModel.removeQuickStop, addFunc: viewModel.addQuickStop)
            configItem(name: "Pausa Longa", value: "\(viewModel.customTime.longStop):00", subFunc: viewModel.removeLongStop, addFunc: viewModel.addLongStop)
            
        }
    }
    private func configItem(name: String, value: String, subFunc: @escaping () -> Void, addFunc: @escaping () -> Void) -> some View {
        HStack {
            Text(name)
                .font(.custom("ZillaSlab-Medium", size: 20))
            Spacer()
            HStack {
                ButtonView(text: "-", action: subFunc)
                Text(value)
                    .frame(width: 55)
                    .font(.custom("ZillaSlab-Regular", size: 20))
                ButtonView(text: "+", action: addFunc)
            }
            .frame(width: 128)
            .padding(.trailing, 58)
        }
        .padding(.leading, 33)
    }
}

#Preview {
    ConfigTimerView()
}
