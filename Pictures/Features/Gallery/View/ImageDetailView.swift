//
//  ImageDetailView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import SwiftUI

struct ImageDetailView: View {
    let photo: Photo

    var body: some View {
        AsyncImage(url: URL(string: photo.downloadURL)) { phase in
            switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.2))
                        .overlay {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)

                case .success(let image):
                    VStack(spacing: 16) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .clipped()
                            .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Author: \(photo.author)")
                                .font(.headline)

                            Text("Original size: \(photo.width)w x \(photo.height)h")
                                .font(.footnote)

                            if let url = URL(string: photo.url) {
                                Link("View original website", destination: url)
                                    .font(.footnote)
                                    .foregroundStyle(.blue)
                            }

                            if let downloadURL = URL(string: photo.downloadURL) {
                                Link("Download url", destination: downloadURL)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 12)

                case .failure:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "photo")
                        }
                        .frame(width: 200, height: 200)

                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview {
    let testPhoto = Photo(
        id: "0",
        author: "Test author",
        width: 10,
        height: 10,
        url: "Test website url",
        downloadURL: "https://picsum.photos/id/0/100"
    )
    ImageDetailView(photo: testPhoto)
}
