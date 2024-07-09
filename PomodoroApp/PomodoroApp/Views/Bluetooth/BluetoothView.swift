//
//  BluetoothView.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 20/04/24.
//

import SwiftUI

struct BluetoothView: View {
    @StateObject var bluetoothManager = BluetoothManager()
    @StateObject var viewModel = BluetoothViewModel()

    var body: some View {
        VStack {

            Text("Bluetooth está \(bluetoothManager.isBluetoothEnabled ? "ativado" : "desativado")")
                .padding()

            Button(action: {
               _ = bluetoothManager.connectToPeripheral()
            }) {
                Text("Conectar ao dispositivo")
                    .padding()
            }

            TextField("Digite a mensagem", text: $viewModel.messageToSend) // Entrada para a mensagem
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if let data = viewModel.messageToSend.data(using: .utf8) {
                 _ = bluetoothManager.sendData(data)
                }
            }) {
                Text("Enviar Mensagem")
                    .padding()
            }

            Text("Mensagens Recebidas:")
                .font(.headline)
                .padding()

            List(bluetoothManager.receivedMessages, id: \.self) { message in
                Text(message)
                    .padding()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
