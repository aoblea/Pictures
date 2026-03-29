//
//  GalleryView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel

    init(api: any PhotosAPI) {
        _viewModel = StateObject(wrappedValue: GalleryViewModel(api: api))
    }

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.photos, id: \.self) { photo in
                        NavigationLink {
                            ImageDetailView(photo: photo)
                        } label: {
                            ThumbnailView(urlString: photo.downloadURL)
                        }
                        .onAppear {
                            if photo == viewModel.photos.last {
                                Task { await viewModel.loadNextPage() }
                            }
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Gallery")
            .task {
                await viewModel.loadInitialPage()
            }
        }
    }
}

#Preview {
    GalleryView(api: NetworkClient())
}
