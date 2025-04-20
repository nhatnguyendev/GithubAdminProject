//
//  ImageCache.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import Foundation
import UIKit

// Handled data race, so marks @unchecked Sendable
public final class ImageCache: ImageCacheType, @unchecked Sendable {
    public static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, CacheEntry>()
    private let queue = DispatchQueue(
        label: "com.githubAdmin.imagecache.queue",
        qos: .userInitiated
    )

    private class CacheEntry {
        let image: UIImage
        let expiryDate: Date

        init(image: UIImage, expiry: TimeInterval) {
            self.image = image
            self.expiryDate = Date().addingTimeInterval(expiry)
        }

        var isExpired: Bool {
            return Date() > expiryDate
        }
    }

    public func image(for url: URL) -> UIImage? {
        return queue.sync {
            guard let entry = cache.object(forKey: url as NSURL), !entry.isExpired else {
                cache.removeObject(forKey: url as NSURL)
                return nil
            }
            return entry.image
        }
    }

    public func insertImage(_ image: UIImage, for url: URL, withExpiry expiry: TimeInterval) {
        queue.async {
            let entry = CacheEntry(image: image, expiry: expiry)
            self.cache.setObject(entry, forKey: url as NSURL)
        }
    }
}

