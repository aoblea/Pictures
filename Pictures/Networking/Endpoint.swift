//
//  Endpoint.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

// https://picsum.photos/v2/list?page=2&limit=100

/// Contains a list of endpoints.
enum Endpoint {
    /// An endpoint that will be used to return a list of photos.
    /// - page: A string that  represents a page number.
    /// - limit: A string that represent the limit of how many photos are retrieved.
    case list(page: String, limit: String)
}

extension Endpoint {
    var url: URL {
        return urlComponents.url!
    }
}

// MARK: - Private
private extension Endpoint {
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
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
}
