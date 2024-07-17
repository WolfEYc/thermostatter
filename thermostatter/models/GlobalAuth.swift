//
//  GlobalAuth.swift
//  thermostatter
//
//  Created by wolfey on 7/7/24.
//

import Foundation

@MainActor class GlobalAuth : ObservableObject {
    @Published var user: Optional<User>
    
    private init () {
        user = nil
//        Task {
//            let user = await get_credential_state()
//            self.set_user(user: user)
//        }
    }
    
    func set_user(user: User?) {
        self.user = user;
        user?.save_to_disk()
    }
    
    static let shared = GlobalAuth()
}

