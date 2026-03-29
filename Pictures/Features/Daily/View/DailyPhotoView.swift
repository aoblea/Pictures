//
//  DailyPhotoView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import SwiftUI

struct DailyPhotoView: View {
    @StateObject private var viewModel: DailyPhotoViewModel

    init(api: any PhotosAPI) {
        _viewModel = .init(wrappedValue: DailyPhotoViewModel(api: api))
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
                    }

                    if let photo = viewModel.photo {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Author: \(photo.author)")
                                .font(.callout)

                            Text("Frame: \(photo.width)w × \(photo.height)h")
                                .font(.footnote)
                                .foregroundStyle(.secondary)

                            if let url = URL(string: photo.url) {
                                Link("Website", destination: url)
                                    .font(.footnote)
                            }

                            if let downloadURL = URL(string: photo.downloadURL) {
                                Link("Download", destination: downloadURL)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    } else if !viewModel.isLoading, let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Today’s Photo")
            .task {
                await viewModel.loadDailyPhoto()
            }
            .overlay {
                if viewModel.isLoading && viewModel.photo == nil {
                    ProgressView("Loading today’s photo…")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    DailyPhotoView(api: NetworkClient())
}
