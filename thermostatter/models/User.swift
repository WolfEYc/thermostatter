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
    let id: String
    let email: String
    let first_name: String?
    let last_name: String?
    private static let saved_user_key = "appleAuthorizedUserKey"
    
    func persist() {
         guard let data = try? PropertyListEncoder().encode(self) else {
             return
         }
        UserDefaults.standard.set(data, forKey: User.saved_user_key)
    }
    
    static func load_from_persisted() -> Optional<User> {
        guard let persisted = UserDefaults.standard.value(forKey: User.saved_user_key) as? Data else {
            return nil
        }
        
        return try? PropertyListDecoder().decode(User.self, from: persisted)
    }
    
    static func load_from_api(id: String) -> Optional<User> {
        return User(id: id, email: "joe@mama.com", first_name: "joe", last_name: "mama")
    }
}


struct UserKey: EnvironmentKey {
    static let defaultValue = User(id: "69420", email: "joe@mama.com", first_name: "joe", last_name: "mama")
}

extension EnvironmentValues {
    var user: User {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}
