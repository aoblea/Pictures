//
//  PhotosAPI.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/27/26.
//

protocol PhotosAPI {
    /// Fetches photos in a paginated way.
    /// 
    /// - Parameter request: The request.
    ///
    /// - Returns: A `[Photo]`.
    func fetchPhotos(_ request: PagingRequest) async throws -> [Photo]
    
    /// Fetches details of the photo using the specified `photoID`.
    ///
    /// - Parameter photoID: The photo identifier.
    ///
    /// - Returns: A `Photo`.
    func fetchPhotoDetails(photoID: PhotoID) async throws -> Photo

    /// Fetches details of the photo using the specified `seedID`.
    ///
    /// - Parameter seedID: The seed identifier.
    ///
    /// - Returns: A `Photo`.
    func fetchPhotoDetails(seedID: SeedID) async throws -> Photo
}
