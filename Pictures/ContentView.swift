//
//  ContentView.swift
//  Pictures
//
//  Created by Arwin Oblea on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: AppModel

    var body: some View {
        TabView {
            GalleryView(api: app.photosAPI)
                .tabItem {
                    Label("Gallery", systemImage: "square.grid.2x2")
                }

            DailyPhotoView(api: app.photosAPI)
                .tabItem { Label("Today's Photo", systemImage: "calendar") }

            RandomPhotoView(api: app.photosAPI)
                .tabItem { Label("Random", systemImage: "shuffle") }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(
            AppModel(photosAPI: NetworkClient())
        )
}
