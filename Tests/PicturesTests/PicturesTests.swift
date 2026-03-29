//
//  PicturesTests.swift
//  PicturesTests
//
//  Created by Arwin Oblea on 3/27/26.
//

import Testing
@testable import Pictures

struct PicturesTests {
    let client = NetworkClient()

    @Test func fetchPhotosDefault() async throws {
        let photos = try await client.fetchPhotos(.init())
        #expect(photos.isEmpty == false)
        #expect(photos.count == 30)
        #expect(photos.first?.id == "0")
    }

    @Test func fetchPhotosLimit() async throws {
        let photos = try await client.fetchPhotos(.init(page: 2, limit: 5))
        #expect(photos.isEmpty == false)
        #expect(photos.count == 5)
        #expect(photos.first?.id == "5")
    }

    @Test func fetchPhotoDetailsByPhotoID() async throws {
        let photoDetails = try await client.fetchPhotoDetails(photoID: "0")
        #expect(photoDetails.id == "0")
    }

    @Test func fetchPhotoDetailsBySeedID() async throws {
        let photoDetails = try await client.fetchPhotoDetails(seedID: "picsum")
        #expect(photoDetails.id == "866")
    }
}
