//
//  ImageCacheType.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import UIKit

public protocol ImageCacheType {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage, for url: URL, withExpiry expiry: TimeInterval)
}
