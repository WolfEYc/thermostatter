//
//  ContentView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State var user: User?
    
    var body: some View {
        Group {
            switch user {
            case nil:
                LoginView(user: $user)
            case .some(let user):
                DeviceListView().environment(\.user, user)
            }
        }.task {
            user = await User.from_keychain()
        }
    }
    
}


#Preview {
    MainView()
}
