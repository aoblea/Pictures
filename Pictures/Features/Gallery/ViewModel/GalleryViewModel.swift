//
//  GalleryViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

import Combine

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let api: PhotosAPI
    private var page = 1

    init(api: PhotosAPI) {
        self.api = api
    }

    func loadInitialPage() async {
        guard photos.isEmpty else { return }
        await loadNextPage()
    }

    func loadNextPage() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let request = PagingRequest(page: page)
            let fetchedPhotos = try await api.fetchPhotos(request)
            photos.append(contentsOf: fetchedPhotos)
            page += 1
        } catch {
            errorMessage = "Failed to load photos."
        }
    }
}
