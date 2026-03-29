//
//  AppModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/29/26.
//

import Combine
import SwiftUI

@MainActor
final class AppModel: ObservableObject {
    let photosAPI: PhotosAPI

    init(photosAPI: PhotosAPI) {
        self.photosAPI = photosAPI
    }
}
