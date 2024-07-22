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
            ZStack {
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink("+ New Device") {
                            NewDeviceView()
                        }
                    }.padding(25)
                    Spacer()
                }
                VStack {
                    Text(user.username)
                    Text(user.access_token)
                }
            }
        }
    }
}

#Preview {
    DeviceListView()
}
