//
//  PomodoroTimerView.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 09/04/24.
//

import SwiftUI

struct PomodoroTimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel()
    @StateObject var bluetoothManager = BluetoothManager()
    @State private var showAlert = false
    
    var body: some View {
            VStack(spacing: 30) {
                VStack(spacing: 45) {
                    TitleView(title: "Pomodoro Timer")
                        .padding(.top, 29)
                    bluetoothButton
                }
                circles
                    .frame(width: 350)
                Spacer()
//                Button("remove Timer", action: viewModel.removeTimer)
                
            }
            .overlay(
                CustomAlertView(title: "Conexão não efetuada", text: "Não foi possível conectar ao dispositivo. Tente novamente.", isPresented: $showAlert),
                alignment: .center
            )
            .onReceive(viewModel.timer) { time in
                viewModel.tick()
            }
            .onAppear() {
                viewModel.loadTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    _ = !bluetoothManager.connectToPeripheral()
                }
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
                Text("\(viewModel.result.remainingTimeFormated)")
                    .font(.custom("ZillaSlab-Bold", size: 48))
                
                Text("\(viewModel.currentPhase)")
                    .font(.custom("ZillaSlab-Medium", size: 20))
            }
            
        }
        .padding(60)
    }
    
    var bluetoothButton: some View {
        HStack {
            Spacer()
            Button(action: {
                showAlert = !bluetoothManager.connectToPeripheral()
            }) {
                bluetoothText
            }
            .disabled(bluetoothManager.isConnected)
            .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 1)
            Spacer()
        }
        
    }
    
    var bluetoothText: some View {
        if (bluetoothManager.isConnected) {
            Text("Conectado ao dispositivo")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Bold", size: 18))
                .padding(.vertical, 6)
                .padding(.horizontal, 16 )
                .background(Color(UIColor.whiteButtonColor.asColor))
                .cornerRadius(50)
                .overlay(
                     RoundedRectangle(cornerRadius: 50)
                         .stroke(Color.black, lineWidth: 0)
                 )



        } else {
            Text("Clique para conectar ao dispositivo")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Bold", size: 18))
                .padding(.vertical, 6)
                .padding(.horizontal, 16 )
                .background(Color(UIColor.connectColor.asColor))
                .cornerRadius(50)
                .overlay(
                     RoundedRectangle(cornerRadius: 50)
                         .stroke(Color(UIColor.mainColor.asColor), lineWidth: 1)
                 )
        }
    }
}

#Preview {
    PomodoroTimerView()
}
