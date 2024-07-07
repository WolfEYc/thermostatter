//
//  DeviceListView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI

struct DeviceListView: View {
    @StateObject var global_auth = GlobalAuth.shared;

    var body: some View {
        NavigationView {
            Text(global_auth.current_user_id ?? "shitballs")
        }
    }
}

#Preview {
    DeviceListView()
}
