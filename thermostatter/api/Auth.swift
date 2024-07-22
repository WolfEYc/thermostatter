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
let register_url = URL(string: register_endpoint, relativeTo: host)!

struct AuthenticateRes: Codable {
    let access_token: String
    let token_type: String
}

let authenticate_request_headers = [
    "Content-Type": "application/x-www-form-urlencoded"
]

let json_content_type_header = [
    "Content-Type": "application/json"
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
    print(String(data: data, encoding: .utf8)!)
    
    let data_decoded = try JSONDecoder().decode(AuthenticateRes.self, from: data)
    return data_decoded
}

func register(email: String, username: String, password: String) async throws -> AuthenticateRes {
    let payload_dict = ["email": email, "username": username, "password": password]
    let payload = try JSONEncoder().encode(payload_dict)
    var req = URLRequest(url: register_url)
    req.httpMethod = "POST"
    req.httpBody = payload
    req.allHTTPHeaderFields = json_content_type_header
    
    let (data, _) = try await URLSession.shared.data(for: req)
    print(String(data: data, encoding: .utf8)!)
    let data_decoded = try JSONDecoder().decode(AuthenticateRes.self, from: data)
    return data_decoded
}
