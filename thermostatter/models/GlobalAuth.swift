//
//  GlobalAuth.swift
//  thermostatter
//
//  Created by wolfey on 7/7/24.
//

import Foundation

class GlobalAuth : ObservableObject {
    @Published var user: Optional<User>
    
    private init () {
        user = nil
    }
    static let shared = GlobalAuth()
}

