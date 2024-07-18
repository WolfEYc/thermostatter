//
//  extensions.swift
//  thermostatter
//
//  Created by wolfey on 7/6/24.
//

import Foundation
import SwiftUI

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

protocol TryFrom {
    associatedtype FromType
    static func try_from(_: FromType) -> Self?
}

protocol From {
    associatedtype FromType
    static func from (_: FromType) -> Self
}

extension Bundle {
    /// Application name shown under the application icon.
    var applicationName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}

let bundle_id = Bundle.main.bundleIdentifier.unsafelyUnwrapped
let app_name = Bundle.main.applicationName;


func validate_username(_ value: String) -> Bool {
    if value.count < 2 || value.count > 30 {
        return false
    }
    return true
}

func validate_email(_ value: String) -> Bool {
    let regex = /^[^\.\s][\w\-\.{2,}]+@([\w-]+\.)+[\w-]{2,}$/
    return value.wholeMatch(of: regex) != nil
}

func validate_password(_ value: String) -> Bool {
    if value.count < 8 || value.count > 16 {
        return false
    }
    return true
}
