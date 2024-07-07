//
//  GlobalAuth.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import Foundation
import AuthenticationServices


class GlobalAuth: ObservableObject {
    @Published var current_user_id: Optional<String> = .none;
    
    static let shared = GlobalAuth()
    private static let user_id_saved_key = "appleAuthorizedUserIdKey"
    private init() {
        // Private initializer to prevent creating multiple instances
        Task {
            @MainActor in
            current_user_id = await get_credential_state()
        }
    }

    
    func handle_login_success(with authorization: ASAuthorization) {
        guard let creds = authorization.credential as? ASAuthorizationAppleIDCredential else {
            current_user_id = .none
            return
        }
        current_user_id = creds.user
        UserDefaults.standard.setValue(current_user_id, forKey: GlobalAuth.user_id_saved_key)
    }
    
    func handle_login_failure(with error: Error) {
        current_user_id = .none
    }
    
    func get_credential_state() async -> Optional<String> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        guard let user_id = UserDefaults.standard.string(forKey: GlobalAuth.user_id_saved_key) else {
            return nil
        }

        let creds = try? await appleIDProvider.credentialState(forUserID: user_id)
        
        if creds == .some(.authorized) {
            return user_id
        }
        return nil
    }
    
}
