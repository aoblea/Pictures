//
//  PagingRequest.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/28/26.
//

struct PagingRequest {
    let page: Int?
    let limit: Int?

    init(
        page: Int? = nil,
        limit: Int? = nil
    ) {
        self.page = page
        self.limit = limit
    }
}
