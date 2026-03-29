//
//  StringValue.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

protocol StringValue {
    var stringValue: String { get }
}

extension Int: StringValue {
    var stringValue: String { String(self) }
}
extension String: StringValue {
    var stringValue: String { self }
}
