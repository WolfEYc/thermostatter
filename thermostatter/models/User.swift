//
//  User.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import Foundation
import AuthenticationServices
import SwiftUI


struct User {
    let id: String
    let email: String
    let name: PersonNameComponents
    private static let saved_user_key = "appleAuthorizedUserKey"
    
    static func from_apple_creds(apple_user: ASAuthorizationAppleIDCredential) -> Optional<Self> {
        guard let apple_email = apple_user.email, let apple_name = apple_user.fullName else {
            return nil
        }
        return Self(id: apple_user.user, email: apple_email, name: apple_name)
    }
    
    func persist() {
        UserDefaults.standard.setValue(self, forKey: User.saved_user_key)
    }
    
    static func load_from_persisted() -> Optional<User> {
        guard let persisted = UserDefaults.standard.object(forKey: User.saved_user_key) else {
            return nil
        }
        return persisted as? User
    }
}

struct UserKey: EnvironmentKey {
    static let defaultValue = User(id: "69420", email: "joe@mama.com", name: PersonNameComponents(givenName: "joe", familyName: "mama"))
}

extension EnvironmentValues {
    var user: User {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}
