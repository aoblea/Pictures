//
//  ThumbnailView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

import SwiftUI

struct ThumbnailView: View {
    let urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.2))
                        .overlay {
                            ProgressView()
                        }
                        .frame(height: 100)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                case .failure:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "photo")
                        }
                        .frame(height: 100)

                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview {
    ThumbnailView(urlString: "https://picsum.photos/id/0/100")
}
