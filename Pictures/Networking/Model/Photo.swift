//
//  Photo.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

struct Photo: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
