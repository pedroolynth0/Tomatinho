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
    @State private var showAlert = false
    @State private var showAlertStartError = false
    
    var body: some View {
        VStack {
            TitleView(title: "Configuração do Timer")
                .padding(.top, 29)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 45) {
                    Spacer()
                    gridTimers
                    button
                    Spacer()
                }
            }
        }
        .overlay(
            CustomAlertView(title: "Conexão não efetuada", text: "Não foi possível conectar ao dispositivo. Tente novamente.", isPresented: $showAlert),
            alignment: .center 
        )
        .overlay(
            CustomAlertView(title: "Não foi possível criar os timers!", text: "Dispositivo desconectado. Realize a conexão bluetooth.", isPresented: $showAlertStartError),
            alignment: .center
        )
    }
    
    var button: some View {
        HStack {
            Spacer()
            Button(action: {
                    pomodoroFlow.customTimer = viewModel.customTime
                    pomodoroFlow.saveTime(customTimer: viewModel.customTime)
            }) {
                Image(systemName: "play.fill")
                    .resizable()
                    .foregroundStyle(Color.white)
                    .frame(width: 25, height: 25)
                    .padding(33)
                    .background(Color(UIColor.playButtonColor.asColor))
                    .clipShape(Circle())
            }
            Spacer()
        }
        .padding(.top, 30)
        
    }
    
    var gridTimers: some View {
        VStack(alignment: .center ,spacing: 50) {
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

        }
        .padding(.horizontal, 43)
    }
}

#Preview {
    ConfigTimerView()
}
