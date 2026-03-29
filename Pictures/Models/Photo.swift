//
//  Photo.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

struct Photo: Hashable {
    let id: PhotoID
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
}

extension Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url, downloadURL = "download_url"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(PhotoID.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        url = try container.decode(String.self, forKey: .url)
        downloadURL = try container.decode(String.self, forKey: .downloadURL)
    }
}
