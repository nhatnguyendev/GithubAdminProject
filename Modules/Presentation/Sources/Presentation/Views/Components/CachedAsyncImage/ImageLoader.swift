//
//  ImageLoader.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import SwiftUI
import Combine

public final class ImageLoader: ObservableObject {
    @Published public var image: UIImage?

    private var cancellable: AnyCancellable?
    private let cache: ImageCacheType
    private let session: URLSession
    private let cacheExpiry: TimeInterval

    public init(
        cache: ImageCacheType = ImageCache.shared,
        session: URLSession = .shared,
        cacheExpiry: TimeInterval = 5 * 60 // 5 minutes
    ) {
        self.cache = cache
        self.session = session
        self.cacheExpiry = cacheExpiry
    }

    public func load(from url: URL) {
        if let cached = cache.image(for: url) {
            self.image = cached
            return
        }

        cancellable = session.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .handleEvents(receiveOutput: { [weak self] image in
                if let image = image {
                    self?.cache.insertImage(image, for: url, withExpiry: self?.cacheExpiry ?? 86400)
                }
            })
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink { [weak self] in self?.image = $0 }
    }
}
