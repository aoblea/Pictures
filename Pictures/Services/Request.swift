//
//  Request.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

struct Request {
    let path: String?
    let query: [String: StringValue?]

    init(
        path: String? = nil,
        query: [String: StringValue?] = [:]
    ) {
        self.path = path
        self.query = query
    }
}

extension Request {
    func getURL() -> URL? {
        guard var components = URLComponents(string: "https://picsum.photos") else { return nil }
        if let path {
            components.path = path
        }
        if !query.isEmpty {
            components.queryItems = query.map {
                URLQueryItem(name: $0.key, value: $0.value?.stringValue)
            }
        }

        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request.url
    }
}
