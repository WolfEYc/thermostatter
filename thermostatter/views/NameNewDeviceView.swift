//
//  NameNewDeviceView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI

let min_device_name_len = 3
let max_device_name_len = 30

struct NameNewDeviceView: View {
    @Binding var device_name: String?
    @State var in_progress_name = ""
    @State var is_device_name_valid = false
    @State var show_alert = false
    
    func handleSubmit() {
        if !is_device_name_valid {
            show_alert = true
            return
        }
        device_name = in_progress_name
    }
    
    func validate_device_name(name: String) -> Bool {
        return name.count >= min_device_name_len && name.count <= max_device_name_len
    }
    
    var body: some View {
        VStack{
            Text("Name your thermostat").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().padding()
            Form {
                TextField("Device Name", text: $in_progress_name)
                    .onChange(of: in_progress_name) {
                        is_device_name_valid = validate_device_name(name: in_progress_name)
                    }
                Section("REQUIREMENTS") {
                    RequirementLabel(text: "Name must be between 3-30 characters", checked: is_device_name_valid)
                }
                Button(action: handleSubmit) {
                    Text("Submit")
                }
            }
        }
        .alert("Name must be between 3-30 characters", isPresented: $show_alert) {
            Text("Ok")
        }
    }
}

#Preview {
    @State var dname: String? = nil
    return NameNewDeviceView(device_name: $dname)
}
