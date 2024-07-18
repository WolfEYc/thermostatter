//
//  User.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import Foundation
import AuthenticationServices
import SwiftUI


struct User: Codable {
    let username: String
    let access_token: String
}

struct UserKey: EnvironmentKey {
    static let defaultValue = User(username: "example_user_name", access_token: "fake_token")
}

extension User {
    static func from_keychain() async -> User? {
        guard let creds = keychain_load() else {
            return nil
        }
        guard let auth_res = try? await authenticate(username: creds.username, password: creds.password) else {
            return nil
        }
        return User(username: creds.username, access_token: auth_res.access_token)
    }
}

extension EnvironmentValues {
    var user: User {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}
