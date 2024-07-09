//
//  AppleSignInComponent.swift
//  thermostatter
//
//  Created by wolfey on 7/6/24.
//

import SwiftUI
import AuthenticationServices


struct AppleSignInComponent: View {
    @StateObject var global_auth = GlobalAuth.shared;
    @State var showing_alert = false
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
        // authorization request for an Apple ID
        request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            // completion handler that is called when the sign-in completes
            switch result {
            case .failure(let error):
                apple_handle_login_failure(with: error)
                showing_alert = true
            case .success(let auth):
                Task {
                    let user = await apple_handle_login_success(with: auth)
                    GlobalAuth.shared.set_user(user: user)
                    showing_alert = user == nil
                }
            }
        }
        .frame(height: 60)
        .alert("Apple Sign in Failed", isPresented: $showing_alert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    
}

#Preview {
    AppleSignInComponent()
}
