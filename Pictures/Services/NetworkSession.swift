//
//  NetworkSession.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/27/26.
//

import Foundation

protocol NetworkSession {
    var session: URLSession { get }
    func dataTask(with request: Request) async throws -> Data
}

/// Handles networking errors.
enum NetworkError: Error {
    /// An indication that the network request failed.
    case requestFailed
    /// An indication that the data retrieved is invalid.
    case invalidData
    /// An indication that the request URL is invalid.
    case invalidURL
    /// An indication that the response code is not good.
    case responseUnsuccessful(String)
}
