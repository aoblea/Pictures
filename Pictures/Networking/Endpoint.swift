//
//  Endpoint.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

// https://picsum.photos/v2/list?page=2&limit=100

enum Endpoint {
    case list(page: String, limit: String)
}

private extension Endpoint {
    var url: URL {
        return components.url!
    }
    
    var base: String {
        return "https://picsum.photos"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/v2/list"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .list(let page, let limit):
            return [
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "limit", value: limit)
            ]
        }
    }
    
    var components: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
}
