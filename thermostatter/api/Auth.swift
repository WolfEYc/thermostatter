//
//  Auth.swift
//  thermostatter
//
//  Created by wolfey on 7/14/24.
//

import Foundation


let auth_prefix = "/auth"

let token_endpoint = auth_prefix + "/token"
let user_info_endpoint = auth_prefix + "/userinfo"
let register_endpoint = auth_prefix + "/register"

let token_url = URL(string: token_endpoint, relativeTo: host)!
let user_info_url = URL(string: user_info_endpoint, relativeTo: host)!


struct AuthenticateRes: Codable {
    let access_token: String
    let token_type: String
}

let authenticate_request_headers = [
    "Content-Type": "application/x-www-form-urlencoded"
]

func authenticate(username: String, password: String) async throws -> AuthenticateRes {
    var components = URLComponents()
    components.queryItems = [URLQueryItem(name: "username", value: username),
                              URLQueryItem(name: "password", value: password)]

    var req = URLRequest(url: token_url)
    req.httpMethod = "POST"
    req.httpBody = components.query?.data(using: .utf8)
    req.allHTTPHeaderFields = authenticate_request_headers
    
    let (data, _) = try await URLSession.shared.data(for: req)
    
    let data_decoded = try JSONDecoder().decode(AuthenticateRes.self, from: data)
    return data_decoded
}

func register(email: String, username: String, password: String) async throws -> AuthenticateRes {
    return AuthenticateRes(access_token: "bean", token_type: "bearer")
}
