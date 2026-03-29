//
//  PhotoID.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

struct PhotoID: Hashable {
    private let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension PhotoID: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }
}

extension PhotoID: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.rawValue = value
    }
}

extension PhotoID: CustomStringConvertible {
    var description: String { rawValue }
}
