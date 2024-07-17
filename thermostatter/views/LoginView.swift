//
//  LoginView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI


struct LoginView: View {
    @State var res_str: String = "Loading..."
    let username = "test"
    let password = "test"
    
    var body: some View {
        VStack {
            Text(res_str)
        }.task {
            do {
                let res = try await authenticate(username: username, password: password)
                res_str = res.access_token
            } catch  {
                res_str = "\(error)"
            }
        }
    }
}

#Preview {
    LoginView()
}
