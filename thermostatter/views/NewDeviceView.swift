//
//  NewDeviceView.swift
//  thermostatter
//
//  Created by wolfey on 7/21/24.
//

import SwiftUI
import CoreBluetooth


struct NewDeviceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var bluetooth_manager = BluetoothManager() // this is Bluetooth manager
    @State var selected_device: CBPeripheral?
    @State var device_name: String?
    @State var wifiSSID: String?
    @State var wifiPassword: String?
    
    func is_connected_to_wifi() -> Bool {
        return bluetooth_manager.receivedData == "WIFI connected"
    }
    
    func return_to_device_list() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        if selected_device == nil {
            ScanNewDeviceListView(peripherals: bluetooth_manager.discoveredPeripherals, selected_device: $selected_device)
        } else if device_name == nil {
            NameNewDeviceView(device_name: $device_name)
        } else if !is_connected_to_wifi() {
            ConnectDeviceWifiView()
        } else {
            let device_name = device_name!
            NewDeviceConnectSucessView(deviceName: device_name, onClear: return_to_device_list)
        }
    }
}

#Preview {
    NewDeviceView()
}
