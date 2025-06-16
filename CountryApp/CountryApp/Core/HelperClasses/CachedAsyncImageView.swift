//
//  CachedAsyncImageView.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI

struct CachedAsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loader.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            loader.load(from: url)
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
