//
//  KeychainService.swift
//  thermostatter
//
//  Created by wolfey on 7/14/24.
//

import Foundation


    
func keychain_save(username: String, password: String) -> OSStatus {
    let credentials: [String: String] = ["username": username, "password": password]
    let credentialsData = try! JSONSerialization.data(withJSONObject: credentials, options: .fragmentsAllowed)

    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: bundle_id,
        kSecValueData: credentialsData
    ] as CFDictionary

    SecItemDelete(query)
    return SecItemAdd(query, nil)
}

func keychain_load() -> (username: String, password: String)? {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: bundle_id,
        kSecReturnData: kCFBooleanTrue!,
        kSecMatchLimit: kSecMatchLimitOne
    ] as CFDictionary

    var dataTypeRef: AnyObject? = nil
    let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)

    if status == errSecSuccess {
        if let retrievedData = dataTypeRef as? Data,
           let credentials = try? JSONSerialization.jsonObject(with: retrievedData, options: .fragmentsAllowed) as? [String: String],
           let username = credentials["username"],
           let password = credentials["password"] {
            return (username, password)
        }
    }
    return nil
}

func keychain_delete() -> OSStatus {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: bundle_id
    ] as CFDictionary

    return SecItemDelete(query)
}

