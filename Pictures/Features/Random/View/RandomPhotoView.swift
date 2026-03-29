//
//  RandomPhotoView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import SwiftUI

struct RandomPhotoView: View {
    @StateObject private var viewModel: RandomPhotoViewModel

    init(api: any PhotosAPI) {
        _viewModel = .init(wrappedValue: RandomPhotoViewModel(api: api))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if let photo = viewModel.photo {
                        AsyncImage(url: URL(string: photo.downloadURL)) { phase in
                            switch phase {
                            case .empty:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.gray.opacity(0.2))
                                    .frame(maxWidth: 300, maxHeight: 400)
                                    .overlay {
                                        ProgressView()
                                    }

                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 300, maxHeight: 400)
                                    .clipped()
                                    .padding(.horizontal)

                            case .failure:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.gray.opacity(0.2))
                                    .frame(maxWidth: 300, maxHeight: 400)
                                    .overlay {
                                        Image(systemName: "photo")
                                    }

                            @unknown default:
                                EmptyView()
                            }
                        }

                        Button("New Random Photo") {
                            Task {
                                await viewModel.loadRandomPhoto()
                            }
                        }
                        .padding(.top)
                    } else if !viewModel.isLoading, let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Random Photo")
            .task {
                await viewModel.loadRandomPhoto()
            }
            .overlay {
                if viewModel.isLoading && viewModel.photo == nil {
                    ProgressView("Loading random photo…")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    RandomPhotoView(api: NetworkClient())
}
