//
//  ImageLoader.swift
//  CountryApp
//
//  Created by Tapan on 16/06/25.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private static let cache = NSCache<NSURL, UIImage>()
    private var cancellable: AnyCancellable?

    func load(from url: URL) {
        if let cached = Self.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        isLoading = true

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .handleEvents(receiveOutput: { image in
                if let image = image {
                    Self.cache.setObject(image, forKey: url as NSURL)
                }
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { [weak self] in
                self?.image = $0
            })
    }

    func cancel() {
        cancellable?.cancel()
    }
}
