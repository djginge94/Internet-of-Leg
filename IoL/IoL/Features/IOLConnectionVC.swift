//
//  IOLConnectionVC.swift
//  IoL
//
//  Created by Joshua Colley on 01/08/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit
import CoreBluetooth

class IOLConnectionVC: UIViewController {
    
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    let IOL_Service_CBUUID = CBUUID(string: "0x180D")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centralQueue: DispatchQueue = DispatchQueue(label: "com.joshcolley.iol", attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    override func loadView() {
        super.loadView()
        
    }
}

// MARK: Bluetooth Connection
extension IOLConnectionVC: CBPeripheralDelegate, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            self.centralManager?.scanForPeripherals(withServices: [IOL_Service_CBUUID])
            DispatchQueue.main.async {
                
            }
        default: return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.name ?? "No Name")
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        peripheral.services?.forEach({
            print($0.uuid)
            print($0)
        })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        service.characteristics?.forEach({
            print($0.uuid)
            print($0)
        })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
    }
}
