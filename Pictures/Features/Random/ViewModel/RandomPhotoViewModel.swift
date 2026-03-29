//
//  RandomPhotoViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import Combine

@MainActor
final class RandomPhotoViewModel: ObservableObject {
    @Published private(set) var photo: Photo?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let api: PhotosAPI
    private var lastPhotoID: PhotoID?

    init(api: any PhotosAPI) {
        self.api = api
    }

    func loadRandomPhoto() async {
        guard isLoading == false else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let photoID = PhotoID(rawValue: "\(Int.random(in: 1...100))")
            let photo = try await api.fetchPhotoDetails(photoID: photoID)
            self.photo = photo
            self.errorMessage = nil
        } catch {
            errorMessage = "Failed to load random photo."
            print("RandomPhotoViewModel error: \(error)")
        }
    }
}
