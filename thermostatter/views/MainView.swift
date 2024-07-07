//
//  ContentView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject var global_auth = GlobalAuth.shared;
    
    var body: some View {
        if global_auth.current_user_id == .none {
            LoginView()
        } else {
            DeviceListView()
        }
    }
}


#Preview {
    MainView()
}
