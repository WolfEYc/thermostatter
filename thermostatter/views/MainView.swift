//
//  ContentView.swift
//  thermostatter
//
//  Created by wolfey on 7/4/24.
//

import SwiftUI
import SwiftData

extension UIWindow {
    static var current: UIWindow {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return UIWindow()
    }
}


extension UIScreen {
    static var current: UIScreen {
        UIWindow.current.screen
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
