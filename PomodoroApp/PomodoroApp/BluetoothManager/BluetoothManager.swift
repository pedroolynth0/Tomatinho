//
//  BluetoothManager.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 20/04/24.
//

import CoreBluetooth
import UIKit

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    @Published var isBluetoothEnabled = false
    @Published var discoveredPeripherals = [CBPeripheral]()
    @Published var receivedMessages = [String]()
    @Published var isConnected = false

    private var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    private let specificPeripheralName = "Tomatinho"

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        setupAppStateObservers()
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothEnabled = true
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            isBluetoothEnabled = false
            isConnected = false
            connectedPeripheral = nil
        }
    }

    
    private func setupAppStateObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func appWillResignActive() {
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            connectedPeripheral = nil
            isConnected = false
        }
    }

    @objc private func appDidBecomeActive() {
        isConnected = connectToPeripheral()
    }

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            discoveredPeripherals.append(peripheral)
        }
    }

    func connectToPeripheral() -> Bool {
        if centralManager.state == .poweredOff {
            connectedPeripheral = nil
        } else {
            if let peripheral = discoveredPeripherals.first(where: { $0.name == specificPeripheralName }) {
                centralManager.connect(peripheral, options: nil)
                peripheral.delegate = self
            } else {
                isConnected = false
            }
        }
        isConnected = connectedPeripheral?.name == "Tomatinho"
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
            if message == "0" || message == "" {
                do {
                    try DataManager.clearCache();
                } catch {
                    print("ERROR")
                }
            }
        }
    }

    func sendData(_ data: Data) -> Bool {
        guard let peripheral = connectedPeripheral else { return true }

        for service in peripheral.services ?? [] {
            for characteristic in service.characteristics ?? [] {
                if characteristic.properties.contains(.write) {
                    peripheral.writeValue(data, for: characteristic, type: .withResponse)
                }
            }
        }
        return false
    }
}
