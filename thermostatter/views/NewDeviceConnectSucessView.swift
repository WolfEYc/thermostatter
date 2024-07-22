//
//  NewDeviceConnectSucessView.swift
//  thermostatter
//
//  Created by wolfey on 7/21/24.
//

import SwiftUI

struct NewDeviceConnectSucessView: View {
    let deviceName: String
    let onClear: () -> Void
    
    
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill").resizable().foregroundColor(Color.green).frame(width: 50, height: 50).transition(.scale)
            Text(deviceName)
                .font(.title)
            Text("Connected!")
                .font(.title)
            
            Button (action: onClear) {
                Text("Return to device list")
                    .font(.title2)
                    
            }
        }
    }
}

#Preview {
    NewDeviceConnectSucessView(deviceName: "Thermostatter ######") {
    }
}
