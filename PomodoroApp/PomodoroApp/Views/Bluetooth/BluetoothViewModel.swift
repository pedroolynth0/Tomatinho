//
//  BluetoothViewModel.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 20/04/24.
//

import SwiftUI


class BluetoothViewModel: ObservableObject {
    @Published var peripheralName = "Tomatinho"
    @Published var messageToSend = "" // Para armazenar a mensagem a ser enviada
}
