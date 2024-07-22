//
//  ScanNewDeviceListView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import CoreBluetooth

struct ScanNewDeviceListView: View {
    let peripherals: [CBPeripheral]
    @Binding var selected_device: CBPeripheral?
    
    var body: some View {
        VStack {
            Text("Select your thermostat").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().padding()
            List(peripherals, id: \.identifier) { peripheral in
                Button(action: { selected_device = peripheral }) {
                    Text(peripheral.name!)
                }
            }
        }
    }
}

#Preview {
    @State var selected_device: CBPeripheral? = nil
    return ScanNewDeviceListView(peripherals: [], selected_device: $selected_device)
}
