//
//  DeviceListView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI

struct DeviceListView: View {
    @Environment(\.user) var user: User;

    var body: some View {
        NavigationView {
            VStack{
                Text(user.id)
                Text(user.email)
                Text(user.first_name ?? "UNKNOWN")
                Text(user.last_name ?? "UNKNOWN")
            }
        }
    }
}

#Preview {
    DeviceListView()
}
