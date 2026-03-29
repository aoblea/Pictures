//
//  DailyPhotoViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import Combine

@MainActor
final class DailyPhotoViewModel: ObservableObject {
    @Published private(set) var photo: Photo?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let api: PhotosAPI

    init(api: any PhotosAPI) {
        self.api = api
    }

    func loadDailyPhoto() async {
        guard isLoading == false else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            // TODO: - Allow user to search photo by text
            let photo = try await api.fetchPhotoDetails(seedID: "picsum")
            self.photo = photo
            self.errorMessage = nil
        } catch {
            errorMessage = "Failed to load today’s photo."
            print("DailyPhotoViewModel error: \(error)")
        }
    }
}
