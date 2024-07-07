//
//  ContentView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject var global_auth = GlobalAuth.shared
    
    var body: some View {
        switch global_auth.user {
        case nil:
            LoginView()
        case .some(let user):
            DeviceListView().environment(\.user, user)
        }
    }
}


#Preview {
    MainView()
}
