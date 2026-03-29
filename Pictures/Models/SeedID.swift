//
//  SeedID.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

struct SeedID {
    private let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension SeedID: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }
}

extension SeedID: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.rawValue = value
    }
}

extension SeedID: CustomStringConvertible {
    var description: String { rawValue }
}
