//
//  AppleAuth.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import Foundation
import AuthenticationServices


func apple_handle_login_success(with authorization: ASAuthorization) {
    guard let creds = authorization.credential as? ASAuthorizationAppleIDCredential else {
        GlobalAuth.shared.user = nil
        return
    }
    GlobalAuth.shared.user = User.from_apple_creds(apple_user: creds)
}

func apple_handle_login_failure(with error: Error) {
    GlobalAuth.shared.user = nil
}

func get_credential_state() async -> Optional<User> {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    guard let user = User.load_from_persisted() else {
        return nil
    }

    guard let creds = try? await appleIDProvider.credentialState(forUserID: user.id) else {
        return nil
    }
    
    if creds != .authorized {
        return nil
    }
    
    return user
}
