//
//  AppleAuth.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import Foundation
import AuthenticationServices


func apple_handle_login_success(with authorization: ASAuthorization) async -> Optional<User> {
    guard let creds = authorization.credential as? ASAuthorizationAppleIDCredential else {
        return nil
    }
    
    let user = User.try_from(creds)
    if user != nil {
        
        return user
    }
    
    let fetched_user = await User.load_from_api(id: creds.user)
    return fetched_user
}

@MainActor func apple_handle_login_failure(with error: Error) {
    GlobalAuth.shared.set_user(user: nil)
}

func get_credential_state() async -> Optional<User> {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    guard let user = User.load_from_disk() else {
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

extension User: TryFrom {
    typealias FromType = ASAuthorizationAppleIDCredential
    
    static func try_from(_ creds: FromType) -> User? {
        guard let email = creds.email else {
            return nil
        }
        
        return User(id: creds.user, email: email, first_name: creds.fullName?.givenName, last_name: creds.fullName?.familyName)
    }
}
