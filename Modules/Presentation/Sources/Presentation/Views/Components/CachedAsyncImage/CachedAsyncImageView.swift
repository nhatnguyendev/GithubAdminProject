//
//  CachedAsyncImageView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import SwiftUI

public struct CachedAsyncImageView: View {
    
    @StateObject private var loader: ImageLoader
    
    let url: URL?
    let imageSize: CGFloat

    public init(
        url: URL?,
        imageSize: CGFloat,
        loader: ImageLoader? = nil
    ) {
        self.url = url
        self.imageSize = imageSize
        _loader = StateObject(wrappedValue: loader ?? ImageLoader())
    }

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
                    .background(Circle().fill(Color.gray.opacity(0.2)))
            }
        }
        .task(id: url) {
            if let url = url {
                loader.load(from: url)
            }
        }
    }
}
