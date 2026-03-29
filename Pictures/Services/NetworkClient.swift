//
//  NetworkClient.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

/// A client that handles networking.
final class NetworkClient: NetworkSession {
    var session: URLSession
    static var decoder = JSONDecoder()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func dataTask(with request: Request) async throws -> Data {
        guard let url = request.getURL() else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.responseUnsuccessful(response.debugDescription)
        }

        guard !data.isEmpty else {
            throw NetworkError.invalidData
        }

        return data
    }
}

// MARK: - PhotosAPI

extension NetworkClient: PhotosAPI {
    func fetchPhotos(_ request: PagingRequest) async throws -> [Photo] {
        let data = try await dataTask(
            with: .init(
                path: "/v2/list",
                query: [
                    "page": request.page,
                    "limit": request.limit
                ]
            )
        )
        return try Self.decoder.decode([Photo].self, from: data)
    }

    func fetchPhotoDetails(photoID: PhotoID) async throws -> Photo {
        let data = try await dataTask(with: .init(path: "/id/\(photoID)/info"))
        return try Self.decoder.decode(Photo.self, from: data)
    }

    func fetchPhotoDetails(seedID: SeedID) async throws -> Photo {
        let data = try await dataTask(with: .init(path: "/seed/\(seedID)/info"))
        return try Self.decoder.decode(Photo.self, from: data)
    }
}
