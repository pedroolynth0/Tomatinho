//
//  BluetoothManager.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 20/04/24.
//

import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    @Published var isBluetoothEnabled = false
    @Published var discoveredPeripherals = [CBPeripheral]()
    @Published var receivedMessages = [String]()
    @Published var isConnected = false

    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    private let specificPeripheralName = "Tomatinho"

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothEnabled = true
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            isBluetoothEnabled = false
            isConnected = false
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            discoveredPeripherals.append(peripheral)
        }
    }

    func connectToPeripheral() -> Bool {
        if centralManager.state == .poweredOff {
            isConnected = false
        } else {
            if let peripheral = discoveredPeripherals.first(where: { $0.name == specificPeripheralName }) {
                centralManager.connect(peripheral, options: nil)
                peripheral.delegate = self
                isConnected = true
            } else {
                isConnected = false
            }
        }
        return isConnected
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        isConnected = (peripheral.name == specificPeripheralName) // Atualiza a variável
        peripheral.delegate = self
        peripheral.discoverServices(nil) // Descobrir todos os serviços
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if connectedPeripheral == peripheral {
            connectedPeripheral = nil
            isConnected = false // Atualiza a variável após desconexão
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.properties.contains(.read) || characteristic.properties.contains(.notify) {
                peripheral.readValue(for: characteristic)
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value, let message = String(data: value, encoding: .utf8) {
            receivedMessages.append(message) // Armazena a mensagem recebida
            print("Mensagem recebida: \(message)")
        }
    }

    func sendData(_ data: Data) {
        guard let peripheral = connectedPeripheral else { return }

        for service in peripheral.services ?? [] {
            for characteristic in service.characteristics ?? [] {
                if characteristic.properties.contains(.write) {
                    peripheral.writeValue(data, for: characteristic, type: .withResponse)
                }
            }
        }
    }
}
