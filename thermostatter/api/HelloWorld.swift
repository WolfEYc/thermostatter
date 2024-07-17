//
//  HelloWorld.swift
//  thermostatter
//
//  Created by wolfey on 7/13/24.
//

import Foundation

let ping_endpoint = "/ping"
let ping_query_param = "msg"

func ping_server(msg: String) async throws -> String {
    guard var components = URLComponents(string: ping_endpoint) else {
        throw URLError(.badURL)
    }
    components.queryItems = [
        URLQueryItem(name: ping_query_param, value: msg)
    ]
    guard let url = components.url(relativeTo: host) else {
        throw URLError(.badURL)
    }
    var req = URLRequest(url: url)
    req.httpMethod = "GET"
    let (data, _) = try await URLSession.shared.data(for: req)
    let data_decoded = try JSONDecoder().decode(String.self, from: data)
    return data_decoded
}
