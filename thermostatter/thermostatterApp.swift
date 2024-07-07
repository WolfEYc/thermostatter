//
//  thermostatterApp.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import SwiftData

@main
struct thermostatterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    init() {
        print("app startup")
        Task {
            GlobalAuth.shared.user = await get_credential_state()
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
